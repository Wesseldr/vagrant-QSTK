# == Class: qstk
#
# See https://pypi.python.org/pypi/QSTK/
#
#
#
class qstk (
  $desktop                    = 'ubuntu-desktop',
  $desktop_minimal_install    = true,
  $binaryPackages             = ['build-essential'],
  $extraPackages              = ['screen'],
  $pythonPackages             = ['numpy', 'scipy'],
  $version                    = 'system',
  $pip                        = true,
  $dev                        = false,
  $virtualenv                 = false,
  $gunicorn                   = false,
  $manage_gunicorn            = true,
  $provider                   = undef
){

  if $desktop_minimal_install == true {

    # Install a minimal desktop
    package { $desktop:
      ensure          => installed,
      install_options => ['--no-install-recommends']
    }->package { 'indicator-session':
      ensure => installed,
    }

  } else {
    
    # Install a fullBlown desktop (takes forever to install)
        package { $desktop:
      ensure => installed,
    }

  }

  #
  # Set the autostart on
  #
  file { [ "/etc/lightdm/", "/etc/lightdm/lightdm.conf.d/" ]:
    ensure  => "directory",
    require => Package[$desktop],
  }->
  file { '/etc/lightdm/lightdm.conf.d/50-myconfig.conf':
    source    => "puppet:///files/etc/lightdm/lightdm.conf.d/50-myconfig.conf",
  }

  #
  # Network manager shut-up work around, else it keeps nagging not started
  #
  package { "network-manager":
    ensure => installed,
    install_options => ['--no-install-recommends']
  }->

  service { "network-manager":
    require => [ Package[$desktop], Package["network-manager"] ],
    ensure => running,
    enable => true,
  }->service { "lightdm":
        require => [ Package[$desktop], File['/etc/lightdm/lightdm.conf.d/'] ],
        ensure  => running,
        enable  => true,
  }
  

  file { "/tmp/desktop-setup":
      source  => "puppet:///files/scripts/desktop-setup",
      recurse => remote,
      mode    => 755,
  } 

  exec { "desktop-setup.sh":
    command => '/bin/bash desktop-setup.sh',
    user    => 'vagrant',
    cwd     => '/tmp/desktop-setup',
    require => [ File["/tmp/desktop-setup"], Service["lightdm"] ],
    }    

  user { 'ubuntu':
    ensure           => 'present',
    password         => '$6$hjzPnQ7d$Q/7euX3fT.ZXse8cG88/IgujBDFibVvZo53xzA2r1puqh8fS6b.gC23jOjhYc8sZ4vKqfD20wKzeYddz3I5zt1',
  }

  class { 'python':
    version         => $version,
    pip             => $pip,
    dev             => $dev,
    virtualenv      => $virtualenv,
    gunicorn        => $gunicorn,
    manage_gunicorn => $manage_gunicorn,
    provider        => $provider,
    require         => [ Package[$desktop], Service["network-manager"] ]
  }->package { $binaryPackages:
        ensure => installed,
  }->python::pip {$pythonPackages:
  }->package { $extraPackages:
        ensure => installed,
  }->
  
  #
  # Create git prompt for every console
  #
  exec { 'git-prompt':
    creates => '/usr/local/share/bash-git-prompt',
    command => 'git clone https://github.com/magicmonty/bash-git-prompt.git /usr/local/share/bash-git-prompt',
  }->file { "/etc/profile.d/git-prompt.sh":
    path => "/etc/profile.d/git-prompt.sh",
    ensure => present,
    source => "puppet:///files/etc/profile.d/git-prompt.sh",
  }
}

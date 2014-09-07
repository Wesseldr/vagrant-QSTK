#
# Puppet Vagrant File for creating a full Python development environment
# (c) WesseldR, 2014
#
#

group { "puppet":
     ensure => "present",
}
File { owner => 0, group => 0, mode => 0644 }
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


# PLEASE NOTE! ALL CONFIGURATION IS DONE IN HIERA
# puppet/hiera/hieradata/quantstart-configuration.yaml 
# after changes run
# ./apply_puppet.sh
# And all changes will be applied to your configuration
#

hiera_include('classes')


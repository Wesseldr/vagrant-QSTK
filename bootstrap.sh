#!/bin/bash

# Check if Vagrant run or production run
# Vagrant run check, in that case cd to the correct direcory, else we presume standing in the right
# directory to apply the reletive path puppet command

# Cleanup some mess
#touch /var/lib/cloud/instance/locale-check.skip

if [[ $(whoami) -eq "vagrant" ]]; then
        cd /vagrant
fi

echo " "
echo "S T A R T I N G   I N S T A L L A T I O N. . . . . . ."
echo " "
echo "BE PATIENT!!! It can take over 60 minutes to complete!"
echo "Go grab a drink & some food :-)"
echo " "
echo " "
echo "Preparing for Puppet install....."
echo "================================="
echo " "
#
# Setup the basics for Puppet
#
aptitude -y install puppet libaugeas-ruby git
cp -r ./puppet/hiera/* /etc/puppet/

echo " "
echo "Installing puppet repository....."
echo "================================ "
echo " "
puppet module install ploperations-puppetlabs_apt
puppet apply --modulepath '/etc/puppet/modules:/vagrant/modules:/vagrant/Vagrant/puppet/modules/' -e 'include apt,puppetlabs_apt'
apt-get update && apt-get upgrade

#
# Horrible workaround for getting rid of some depreciations inside the puppet.conf
#
rm -rf /var/lib/puppet
rm -rf /var/puppet/modules
rm -rf /etc/puppet/*
apt-get purge -y puppet
apt-get purge -y puppet-common

echo " "
echo "Installing core puppet ....."
echo "============================"
echo " "
aptitude -y install graphviz vim screen
aptitude -y install -o Dpkg::Options::="--force-confnew" puppet-common puppet 

#
# Setting up the Hiera data structure and the puppet.conf file
#

echo " "
echo "Installing Hiera database and connect Puppet to Hiera....."
echo "=========================================================="
echo " "
cp ./puppet/puppet.conf /etc/puppet/puppet.conf
cp -r ./puppet/hiera/* /etc/puppet/
cp -r ./puppet/manifests/files /etc/puppet/

#
# Add puppet modules system wide, don't like the bulky local modules directories
#
echo " "
echo "Installing Puppet System Modules...."
echo "===================================="
echo " "
#puppet module install puppetlabs-java
puppet module install saz-timezone
puppet module install stankevich-python
#puppet module install puppetlabs-mysql --version 2.2.3
#puppet module install puppetlabs-postgresql
echo " "
echo "Finished installation of Hiera & Puppet, ready for applying Puppet...."
echo "======================================================================"
echo " "
echo "3.2.1."
#
# All preparation is done! now let's run puppet to setup our host
#
./apply_puppet.sh
pip install ipython[notebook]
aptitude -y build-dep python-cvxopt
aptitude -y install python-cvxopt

mkdir QSTK
cd QSTK
wget –quiet http://pypi.python.org/packages/source/Q/QSTK/QSTK-0.2.8.tar.gz  > /dev/null 2>&1
sudo tar zxvf QSTK-0.2.8.tar.gz --owner vagrant --group vagrant --no-same-owner 2>&1 > tar2.log
cd QSTK-0.2.8/Examples/
python Validation.py

echo " "
echo " "
echo "You find your host ./ directory inside the VM at /vagrant, and it is always in sync"
echo "Use it with your native editor to work on your projects"
echo " "
echo "Login with the command line: "
echo "vagrant ssh"
echo " "
echo "Login on the GUI with:"
echo "username: vagrant"
echo "password: vagrant"
echo "sudo su -    works :-)"
echo " "
echo "ROOT account ubuntu:"
echo "username: ubuntu"
echo "password: ubuntu"
echo " "
echo "Happy Coding! :-)"


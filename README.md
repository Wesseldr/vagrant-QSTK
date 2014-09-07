# Vagrant QuantSoftware ToolKit Desktop on Ubuntu 14.x#

This Vagrant box sets up a full QuantSoftware ToolKit Ubuntu installation inside a VirtualMachine with Gnome desktop.
All credits for QuantSoftware Toolkit goes to the team of [QSTK](http://wiki.quantsoftware.org/index.php?title=QuantSoftware_ToolKit), 
Here we just build a complete VirtualMachine around it so it can be easily used on 'any' os as long as it supports the free software VirtualBox from Oracle

Also the [ipython notebook application](http://ipython.org/notebook.html) is installed for easy usages of python code snippets.


### Requirements ###
* [Oracle VM Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Oracle VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
* [Vagrantup](http://www.vagrantup.com/)
* A CPU running OsX, Linux or Windows

### Windows Users, Please Note! Using NFS Synced Folders ###
The current installation uses NFS synced folders (look inside the /Vagrantfile) and is therefor optimised for OsX/Linux hosts. 
If you like to run this Vagrant box on Microsoft (which is no problem) please read this documentation of Vagrant about [NFS Synced Folders](https://docs.vagrantup.com/v2/synced-folders/nfs.html) and how to handle this on Windows


## Quick Start ##
1. Install [Virtualbox](https://www.virtualbox.org/wiki/Downloads),  [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) and [Vagrantup](http://www.vagrantup.com/)
2. Clone this repository, and inside run the command: 

```

$ vagrant up
```

Vagrant will start by installing a vanilla Ubuntu 14.04 inside the VM. It will bring-up the *Ubuntu Unity Desktop* first and afterwards continue's to install:
1. The python packages: numpy,scipy,matplotlib,pandas,python-dateutil,cvxopt,scikit-learn,pyzmq,ipython,pygments,patsy,statsmodels,lxml,qstk
2. ipython notebook
3. Be patient it takes a long time before it all is completed. (on my slow internet almost 50 minutes)
If the full installation was successful you will see the following screen on your terminal:
```
==> default: Notice: Finished catalog run in 3000 seconds
==> default: =================================================================
==> default: || Puppet Applied! Installation and box Configuration Finished ||
==> default: =================================================================
==> default:  
==> default:  
==> default:  
==> default: You find your host ./ directory inside the VM at /vagrant, and it is always in sync
==> default: Use it with your native editor to work on your projects
==> default:  
==> default: Login with the command line: 
==> default: vagrant ssh
==> default:  
==> default: Login on the GUI with:
==> default: username: vagrant
==> default: password: vagrant
==> default: sudo su -    works :-)
==> default:  
==> default: ROOT account ubuntu:
==> default: username: ubuntu
==> default: password: ubuntu
==> default:  
==> default: Happy Coding! :-)
```
Scroll back the screen and check if no errors occurred.

Start a terminal on the Linux desktop and type:
```
ipython notebook 

# or if you like to access notebook from outside the VM:
ipython notebook --ip='*'

```
use the url [http://10.11.12.13:8888/](http://10.11.12.13:8888/) from your own desktop to reach the VM.

yes the correct ip is 10.11.12.13, VirtualBox will handle the routing :-)



Now you can test and run any code snippets on the QSTK pages.




## Customise the installation ##
Feel free to fork me and change :)


All the configuration variables are placed inside the hiera file:

```
#!bash

/vagrant/puppet/hiera/hieradata/quantstart-configuration.yaml
```
To apply new settings just run the script:

```
#!bash

$ sudo ./apply_puppet.sh
```

The Ubuntu desktop tweaks:
```
#!bash

/vagrant/puppet/manifests/files/scripts/desktop-setup/desktop-setup.sh
```
## Package List ##
Below are the different packages used in this Vagrant box:

### Python Package List ###
        - numpy
        - scipy
        - matplotlib
        - pandas
        - python-dateutil
        - cvxopt
        - scikits.statsmodels
        - scikit-learn
        - pyzmq
        - ipython
        - pygments
        - patsy
        - statsmodels
        - lxml
        - qstk


### Binary Libraries ###
        - build-essential 
        - python2.7-dev
        - liblapack-dev  
        - libblas-dev 
        - libatlas-base-dev 
        - gfortran 
        - libpng-dev 
        - libjpeg8-dev 
        - libfreetype6-dev 
        - libzmq-dev
        - libxslt-dev
        - quantlib-python
        - python-numpy
        - python-scipy
        - python-matplotlib
        - python-setuptools
        - python-cvxopt
        - unzip

### Unity Desktop Apps ###
        - ubuntu-desktop
        - gnome-terminal
        - firefox
        - chromium-browser
        - vim-gnome
        - geany
        - meld

Enjoy! 

J.W. de Roode, sep-2014


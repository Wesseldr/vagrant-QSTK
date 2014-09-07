#!/bin/bash
#
# (c) Wessel de Roode, 2014
# Easy to reuse commandline for applying the full puppet cycle. Use for changes and for initial instalation
#
echo " "
echo "Applying Puppet...."
echo "==================="
cp ./puppet/puppet.conf /etc/puppet/puppet.conf
cp -r ./puppet/manifests/files /etc/puppet/

cp -r ./puppet/hiera/* /etc/puppet/
rm /etc/hiera.yaml
ln -s /etc/puppet/hiera.yaml /etc/hiera.yaml

puppet apply --modulepath ./puppet/modules:/etc/puppet/modules:/usr/share/puppet/modules --fileserverconfig=./puppet/fileserver.conf  ./puppet/manifests/site.pp

echo "================================================================="
echo "|| Puppet Applied! Installation and box Configuration Finished ||"
echo "================================================================="
echo " "

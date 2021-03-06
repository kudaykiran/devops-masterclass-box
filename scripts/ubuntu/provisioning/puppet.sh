#!/bin/bash -e -x

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

echo "*** Installing Puppet ***"
curl -O "https://apt.puppetlabs.com/puppet6-release-$(lsb_release -c -s).deb"
dpkg -i puppet6-release-*.deb
rm -rf puppet6-release-*
apt-get -y -qq update -o=Dpkg::Use-Pty=0
apt-get -y -qq install -o=Dpkg::Use-Pty=0 puppet-agent puppet-bolt
cp /tmp/files/hiera.yaml /etc/puppetlabs/puppet
cp /tmp/files/puppet.conf /etc/puppetlabs/puppet

echo "*** Installing r10k ***"
/opt/puppetlabs/puppet/bin/gem install r10k
ln -s /opt/puppetlabs/puppet/bin/r10k /opt/puppetlabs/bin/r10k

echo "*** Checking Puppet installation ***"
/opt/puppetlabs/bin/r10k version
/opt/puppetlabs/bin/puppet --version
/opt/puppetlabs/bin/bolt --version

#!/bin/bash
# script to install Metasploit, Sqlmap, Atscan, Netcat, Tor, Proxychains on GNURoot Debian app
# by @thelinuxchoice
echo "Updating and installing dependencies...";
sleep 2;
apt-get update;
apt-get upgrade -y;
apt-get install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev vncviewer libyaml-dev curl zlib1g-dev gnupg2 wget tor proxychains net-tools netcat -y;
echo "Creating tools dir /tools ...";
sleep 2;
mkdir /tools;
cd /tools;
echo "Installing Sqlmap...";
sleep 2;
git clone "https://github.com/sqlmapproject/sqlmap";
echo "Installing Atscan...";
sleep 2;
git clone "https://github.com/AlisamTechnology/ATSCAN";
echo "Installing Atscan dependencies...";
sleep 2;
perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit';
cpan install App:cpanminus;
cpanm URI::Escape HTML::Entities HTTP::Request LWP::UserAgent;
chmod +x /tools/ATSCAN/atscan.pl;
echo "Installing RVM...";
sleep 2;
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -; 
curl -L https://get.rvm.io | bash -s stable; 
source /etc/profile.d/rvm.sh;
echo "source /etc/profile.d/rvm.sh" >> /home/.bashrc; 
echo "Installing Ruby...";
sleep 2;
RUBYVERSION=$(wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/.ruby-version -q -O -);
rvm install $RUBYVERSION;
rvm use $RUBYVERSION --default;
echo "Installing Metasploit...";
sleep 2;
cd /opt;
git clone https://github.com/rapid7/metasploit-framework.git;
cd metasploit-framework;
rvm --default use ruby-${RUBYVERSION}@metasploit-framework;
gem install bundler;
bundle install;
echo "Creating metasploit symbolic link..."
cd /opt/metasploit-framework;
for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done;
echo "End! Enjoy!";
echo "Features: metasploit+sqlmap+atscan+netcat+tor+proxychains";
echo "tools dir: cd /tools";
echo "Sqlmap dir: cd /tools/sqlmap";
echo "Sqlmap usage: python sqlmap.py -hh";
echo "Atscan dir: cd /tools/ATSCAN";
echo "Atscan usage: perl atscan.pl -h";
echo "Metasploit usage: msfconsole";
echo "Netcat usage for port scan: nc -v -n -z -w 1 192.168.0.10 443"
echo "Follow @thelinuxchoice (Instagram) :)";

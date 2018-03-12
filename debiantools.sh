#!/bin/bash
# script to install Metasploit, Sqlmap, Atscan, Netcat, Tor, Proxychains on GNURoot Debian app
# by @thelinuxchoice
trap 'printf "\e[101m \n Ctrl+C was pressed before instalation ends. Run this script again, exiting.. \n\n \e[0m"; exit 0' 2
printf "\e[101m[*] Warning: Complete installation takes a long time, please wait... \e[0m \n"
printf "\e[1;92mUpdating and installing dependencies...\n \e[0m"
sleep 2;
apt-get update;
apt-get upgrade -y;
apt-get install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev vncviewer libyaml-dev curl zlib1g-dev gnupg2 nano wget tor proxychains net-tools netcat -y;
printf "\e[1;92mCreating tools dir /tools ...\n \e[0m"
sleep 2;
mkdir /tools;
cd /tools;
printf "\e[1;92mInstalling Sqlmap...\n \e[0m"
sleep 2;
git clone "https://github.com/sqlmapproject/sqlmap"
printf "\e[1;92mInstalling Atscan...\n \e[0m"
sleep 2;
git clone "https://github.com/AlisamTechnology/ATSCAN"
printf "\e[1;92mInstalling Atscan dependencies...\n \e[0m"
sleep 2;
perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit';
cpan install App:cpanminus;
cpanm URI::Escape HTML::Entities HTTP::Request LWP::UserAgent;
chmod +x /tools/ATSCAN/atscan.pl;
printf "\e[1;92mInstalling RVM...\n \e[0m";
sleep 2;
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -; 
curl -L https://get.rvm.io | bash -s stable; 
source /etc/profile.d/rvm.sh;
printf "\e[1;92mInstalling Ruby...\n \e[0m";
sleep 2;
RUBYVERSION=$(wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/.ruby-version -q -O -);
rvm install $RUBYVERSION;
rvm use $RUBYVERSION --default;
printf "\e[1;92mInstalling Metasploit-Framework...\n \e[0m";
sleep 2;
cd /opt;
git clone https://github.com/rapid7/metasploit-framework.git;
cd metasploit-framework;
rvm --default use ruby-${RUBYVERSION}@metasploit-framework;
gem install bundler;
printf "\e[1;92mInstalling Ruby modules, please wait...\n \e[0m";
bundle install;
printf "\e[1;92mCreating metasploit symbolic link...\n \e[0m"
cd /opt/metasploit-framework;
for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done;
grep -w "msfconsole" /home/.bashrc >& /dev/null
if [[ $? == "1" ]]; then 
echo "alias msfconsole='source /etc/profile.d/rvm.sh; msfconsole'" >> /home/.bashrc;
echo "alias msfd='source /etc/profile.d/rvm.sh; msfd'" >> /home/.bashrc;
echo "alias msfrpc='source /etc/profile.d/rvm.sh; msfrpc'" >> /home/.bashrc;
echo "alias msfrpcd='source /etc/profile.d/rvm.sh; msfrpcd'" >> /home/.bashrc;
echo "alias msfupdate='source /etc/profile.d/rvm.sh; msfupdate'" >> /home/.bashrc;
echo "alias msfvenom='source /etc/profile.d/rvm.sh; msfvenom'" >> /home/.bashrc;
fi
grep -w "msfconsole" /root/.bashrc >& /dev/null
if [[ $? == "1" ]]; then
echo "alias msfconsole='source /etc/profile.d/rvm.sh; msfconsole'" >> /root/.bashrc;
echo "alias msfd='source /etc/profile.d/rvm.sh; msfd'" >> /root/.bashrc;
echo "alias msfrpc='source /etc/profile.d/rvm.sh; msfrpc'" >> /root/.bashrc;
echo "alias msfrpcd='source /etc/profile.d/rvm.sh; msfrpcd'" >> /root/.bashrc;
echo "alias msfupdate='source /etc/profile.d/rvm.sh; msfupdate'" >> /root/.bashrc;
echo "alias msfvenom='source /etc/profile.d/rvm.sh; msfvenom'" >> /root/.bashrc;
fi

printf "\e[1;92m[+] End! Enjoy!\n\e[0m"
printf "\e[1;92m[+] Features: \e[0m"
printf "\e[1;77m metasploit+sqlmap+atscan+netcat+tor+proxychains \n\e[0m"
printf "\e[1;92m[+] tools dir: \e[0m"
printf "\e[1;77m cd /tools \n\e[0m"
printf "\e[1;92m[+] Sqlmap dir: \e[0m"
printf "\e[1;77mcd /tools/sqlmap \n \e[0m"
printf "\e[1;92m[+] Sqlmap usage: \e[0m"
printf "\e[1;77mpython sqlmap.py -hh \n \e[0m"
printf "\e[1;92m[+] Atscan dir: "
printf "\e[1;77mcd /tools/ATSCAN \n \e[0m"
printf "\e[1;92m[+] Atscan usage: "
printf "\e[1;77mperl atscan.pl -h \n \e[0m"
printf "\e[1;92m[+] Metasploit usage: \e[0m"
printf "\e[1;77mmsfconsole \n"
printf "\e[1;92m[+] Netcat usage for port scan: \e[0m"
printf "\e[1;77mnc -v -n -z -w 1 192.168.0.10 443 \n \e[0m"
printf "\e[101m[*] Follow @thelinuxchoice (Instagram) :) \e[0m \n"

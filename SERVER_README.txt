IP: 208.75.86.29
Root password (slice and mysql): webjamAD3rou

App user: webjam

Logins: lstoll, tlucas/changeme, lachlanhardy/changeme

Gems required on client: capistrano, capistrano-ext

Deploy Environments:
	edge: master branch. (DEFAULT)
		- 
	staging: production branch - for qa before going to prod. DB pull from prod, the migrate
	 	- 
	production: production branch. main site.
		- 
	
Server Software: Apache 2, Phusion Passenger 2.0RC2, MySQL, Ruby Enterprise, Ruby 1.8.6-p231, Rubygems 1.2.0

Notes: If you want to add gems to the rails app's environment, use /opt/

Cool things TODO: Some kind of CI magic. Sinatra app on Passenger Rack, called by github, pulls code, runs tests, emails results.

MySQL accounts added webjam_prod/cREs5usa webjam_edge/Z4n6xAhA webjam_staging/pRehaYe4

Commands run for setup:

apt-get update
apt-get upgrade
mkdir -p /usr/local/src
cd /usr/local/src
wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.6-p230.tar.bz2
tar -xjvf ruby-1.8.6-p230.tar.bz2
wget http://rubyforge.org/frs/download.php/38646/rubygems-1.2.0.tgz
tar -zxvf rubygems-1.2.0.tgz
apt-get install apache2-mpm-prefork apache2 apache2-prefork-dev libapr1-dev zlib1g-dev libssl-dev libncurses5-dev libreadline5-dev build-essential git-core wget nano mysql-server libmysqlclient15-dev	
cd ruby-1.8.6-p230
./configure --with-readline
cd ../rubygems-1.2.0
ruby setup.rb
gem install rake
cd ..
wget http://rubyforge.org/frs/download.php/38084/ruby-enterprise-1.8.6-20080507.tar.gz
tar -zxvf ruby-enterprise-1.8.6-20080507.tar.gz
ruby-enterprise-1.8.6-20080507/installer
#had to ctrl-c the bulk update
cd rubygems-1.2.0
/opt/ruby-enterprise-1.8.6-20080507/bin/ruby setup.rb --prefix=/opt/ruby-enterprise-1.8.6-20080507
# TODO - the next two commands would be find if setup --prefix was fixed.
mv /opt/ruby-enterprise-1.8.6-20080507/lib/*.rb /opt/ruby-enterprise-1.8.6-20080507/lib/ruby/site_ruby/1.8/
mv /opt/ruby-enterprise-1.8.6-20080507/lib/rubygems /opt/ruby-enterprise-1.8.6-20080507/lib/ruby/site_ruby/1.8/
/opt/ruby-enterprise-1.8.6-20080507/bin/gem install rails mysql --no-rdoc --no-ri
cd ..
wget http://phusion-passenger.googlecode.com/files/passenger-1.9.1.gem
/opt/ruby-enterprise-1.8.6-20080507/bin/gem install passenger-1.9.1.gem --no-rdoc --no-ri
/opt/ruby-enterprise-1.8.6-20080507/bin/passenger-install-apache2-module
echo "LoadModule passenger_module /opt/ruby-enterprise-1.8.6-20080507/lib/ruby/gems/1.8/gems/passenger-1.9.1/ext/apache2/mod_passenger.so" > /etc/apache2/mods-available/passenger.load
cat >> /etc/apache2/mods-available/passenger.conf << EOF
PassengerRoot /opt/ruby-enterprise-1.8.6-20080507/lib/ruby/gems/1.8/gems/passenger-1.9.1
PassengerRuby /opt/ruby-enterprise-1.8.6-20080507/bin/ruby
EOF





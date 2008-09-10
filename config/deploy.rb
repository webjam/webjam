set :stages, %w(staging production edge)
set :default_stage, "edge"
require 'capistrano/ext/multistage'
require 'open-uri'

require File.join(File.dirname(__FILE__), "..", "lib", "application_config")
APPLICATION_CONFIG = ApplicationConfig.new

# Common stuff goes here, like perms, servers, and restart stuff

set :ssh_options, { :forward_agent => true } # this is so we don't need a appdeploy key

set :application, "webjam"

set :scm, :git
set :deploy_via, :remote_cache
set :repository, "git@github.com:webjam/webjam.git"

role :app, "208.75.86.29"
role :web, "208.75.86.29"
role :db, "208.75.86.29", :primary => true

set :rake, "/opt/ruby-enterprise-1.8.6-20080507/bin/rake"

set :app_user, "webjamapp"

set :group, "webjamdeploy"

# TODO - investigate security implications. I doubt there is any.
def set_remote_permissions
  sudo <<-CMD
  sh -c "chown -R #{app_user}:#{group} #{deploy_to} &&
  chmod -R g+w #{deploy_to}"
  CMD
end

before "deploy:update_code" do
  sudo <<-CMD
  sh -c "if [ -d #{deploy_to}/shared/cached-copy ]; then chown -R $USER #{deploy_to}/shared/cached-copy; fi;"
  CMD
end

def link_database_config
  sudo "ln -s #{deploy_to}/../config/database.yml #{release_path}/config/database.yml"
  sudo "ln -s #{deploy_to}/../config/application.yml #{release_path}/config/application.yml"
end

def link_mugshots
  sudo "sh -c \"if [ ! -d #{deploy_to}/shared/mugshots ]; then mkdir #{deploy_to}/shared/mugshots; fi;\""
  sudo "ln -s #{deploy_to}/shared/mugshots #{release_path}/public/mugshots"
end

def install_remote_gems
  rake = fetch(:rake, "rake")
  rails_env = fetch(:rails_env, "production")
  sudo "sh -c \"cd #{current_release}; #{rake} RAILS_ENV=#{rails_env} gems:install\""
end

def prestart_application
  puts "About to prestart the application..."
  2.times do
    if site_username && site_password
      s = open(site_url, :http_basic_authentication=>[site_username,site_password])
    else
      open(site_url)
    end
  end
end

task :announce_to_campfire do
  begin
    if APPLICATION_CONFIG.jeeves_campfire_password.nil?
      puts "Jeeves can't announce to campfire. Set jeeves_campfire_password in config/application.yml to github@webjam.com.au's password"
    else
      require File.join(File.dirname(__FILE__), "deploy", "tinder", "lib", "tinder")
      campfire = Tinder::Campfire.new 'webjam'
      campfire.login 'github@webjam.com.au', APPLICATION_CONFIG.jeeves_campfire_password
      room = Tinder::Room.new(campfire, "176805")
      room.speak "[cap #{rails_env} deploy] #{Etc.getlogin} has released the hounds!"
    end
  rescue Tinder::Error => e
    puts e.message + " - Is jeeves_campfire_password in config/application.yml set to github@webjam.com.au's password?"
  end
end

namespace :deploy do
  desc "Custom restart task for passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
    prestart_application
  end

  desc "Custom start task for passenger"
  task :start, :roles => :app do
    # Don't need to do anything, it's automatic
  end

  desc "Custom stop task for passenger"
  task :stop, :roles => :app do
    # currently no way I know of to 'stop' the app
  end
end

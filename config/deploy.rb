set :stages, %w(staging production edge)
set :default_stage, "edge"
require 'capistrano/ext/multistage'

# Common stuff goes here, like perms, servers, and restart stuff

set :ssh_options, { :forward_agent => true } # this is so we don't need a appdeploy key

set :application, "webjam"

set :scm, :git
set :repository, "git@github.com:toolmantim/webjam.git"

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

def link_database_config
  sudo "ln -s #{deploy_to}/../config/database.yml #{release_path}/config/database.yml"
end

def install_remote_gems
  rake = fetch(:rake, "rake")
  rails_env = fetch(:rails_env, "production")
  sudo "sh -c \"cd #{current_release}; #{rake} RAILS_ENV=#{rails_env} gems:install\""
end

namespace :deploy do
  desc "Custom restart task for passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
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

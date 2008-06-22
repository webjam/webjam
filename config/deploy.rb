set :stages, %w(staging production egde)
set :default_stage, "edge"
require 'capistrano/ext/multistage'

# Common stuff goes here, like perms, servers, and restart stuff

set :application, "webjam"

set :scm, :git
set :repository, "git@github.com:toolmantim/webjam.git"

role :app, "208.75.86.29"
role :web, "208.75.86.29"
role :db, "208.75.86.29", :primary => true


set :app_user, "webjamapp"

set :group, "appdeploy"

def set_remote_permissions
  sudo <<-CMD
  sh -c "chown -R #{app_user}:#{group} #{release_path} &&
  chmod -R g+w #{release_path}"
  CMD
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

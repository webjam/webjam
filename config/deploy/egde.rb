# EGDE-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/edge"

set :branch, "master"

task :after_update_code, :roles => :app do
  set_remote_permissions
end
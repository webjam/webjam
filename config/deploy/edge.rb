# EGDE-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/edge"

set :branch, "master"

set :rails_env, "edge"

task :after_update_code, :roles => :app do
  link_database_config
  install_remote_gems
  set_remote_permissions
end
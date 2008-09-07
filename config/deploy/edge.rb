# EGDE-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/edge"

set :branch, "master"

set :rails_env, "edge"

set :site_url, "http://edge.webjam.com.au"

set :site_username, "alpha"
set :site_password, "alpha"

task :after_update_code, :roles => :app do
  link_database_config
  link_mugshots
  install_remote_gems
  set_remote_permissions
  announce_to_campfire
end
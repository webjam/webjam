# PRODUCTION-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/production"

set :branch, "production"

set :rails_env, "production"

set :site_url, "http://www.webjam.com.au"

task :after_update_code, :roles => :app do
  link_database_config
  link_mugshots
  install_remote_gems
  set_remote_permissions
  announce_to_campfire
end
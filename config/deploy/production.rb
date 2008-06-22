# PRODUCTION-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/production"

set :branch, "production"

task :after_update_code, :roles => :app do
  set_remote_permissions
end
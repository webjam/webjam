# STAGING-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/staging"

set :branch, "production"

task :after_update_code, :roles => :app do
  set_remote_permissions
  # remote all tables in this database
end
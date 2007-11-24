set :application, "webjam"
set :deploy_to, "/var/www/webjam.com.au/app"
set :user, "deploy"

set :repository,  "https://dev.aviditybytes.com/svn/webjam/backjam/rails/"
set :scm_username, 'webjam_deploy'
set :scm_password, 'KLna343_aa1'

role :app, "spiderpig.toolmantim.com"
role :web, "spiderpig.toolmantim.com"
role :db,  "spiderpig.toolmantim.com", :primary => true

require File.dirname(__FILE__) + '/mongrel_cluster'

set :mongrel_servers, 1
set :mongrel_port, 9000
set :mongrel_address, "0.0.0.0"
set :mongrel_user, "mongrel"
set :mongrel_group, "www-data"

namespace :deploy do
  desc "Link in the uploaded shtuffs"
  task :after_update_code do
    run "ln -nfs #{shared_path}/mugshots #{release_path}/public/mugshots"
  end
end

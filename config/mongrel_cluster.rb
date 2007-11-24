Capistrano::Configuration.instance(:must_exist).load do
  depend :remote, :gem, "mongrel_cluster", ">=0.2.1"
  after "deploy:setup", "mongrel:cluster:setup"

  set(:mongrel_servers, 3)
  set(:mongrel_port) { abort 'Please configure the mongrel_port variable before deploying' }
  set(:mongrel_address, "127.0.0.1")
  set(:mongrel_environment, "production")
  set(:mongrel_user) { user }
  set(:mongrel_group) { user }
  set(:mongrel_prefix, nil)
  set(:mongrel_num_procs, 3)
  set(:mongrel_conf) { File.join(shared_path, 'config', 'mongrel_cluster.yml') }
  set(:mongrel_startup_file) { File.join('/etc', 'mongrel_cluster', "#{application}.yml") }

  namespace :mongrel do
    namespace :cluster do
      desc <<-DESC
      Configure Mongrel processes on the app server. This uses the :use_sudo
      variable to determine whether to use sudo or not. By default, :use_sudo is
      set to true.
      DESC
      task :setup, :roles => :app do
        argv = []
        argv << "mongrel_rails cluster::configure"
        argv << "-N #{mongrel_servers.to_s}"
        argv << "-p #{mongrel_port.to_s}"
        argv << "-e #{mongrel_environment}"
        argv << "-a #{mongrel_address}"
        argv << "-c #{current_path}"
        argv << "-C #{mongrel_conf}"
        argv << "-n #{mongrel_num_procs}"
        argv << "--user #{mongrel_user}" if mongrel_user
        argv << "--group #{mongrel_group}" if mongrel_group
        argv << "--prefix #{mongrel_prefix}" if mongrel_prefix
        cmd = argv.join " "
        # Try to create shared/config
        run "mkdir -p #{File.dirname(mongrel_conf)}"
        # Run the command to generate a shared/config/mongrel_cluster.yml
        run cmd
        # Try to create /etc/mongrel_cluster
        sudo "mkdir -p #{File.dirname(mongrel_startup_file)}"
        run <<-CMD
          if [ ! -e #{mongrel_startup_file} ] ; then
            sudo ln -s #{mongrel_conf} #{mongrel_startup_file} ; 
          fi
        CMD
      end

      desc <<-DESC
      Start Mongrel processes on the app server.  This uses the :use_sudo variable to determine whether to use sudo or not. By default, :use_sudo is
      set to true.
      DESC
      task :start, :roles => :app do
        sudo "mongrel_rails cluster::start -C #{mongrel_conf}"
      end

      desc <<-DESC
      Restart the Mongrel processes on the app server by starting and stopping the cluster. This uses the :use_sudo
      variable to determine whether to use sudo or not. By default, :use_sudo is set to true.
      DESC
      task :restart, :roles => :app do
        sudo "mongrel_rails cluster::restart -C #{mongrel_conf}"
      end

      desc <<-DESC
      Stop the Mongrel processes on the app server.  This uses the :use_sudo
      variable to determine whether to use sudo or not. By default, :use_sudo is
      set to true.
      DESC
      task :stop, :roles => :app do
        sudo "mongrel_rails cluster::stop -f -C #{mongrel_conf}"
      end

      desc <<-DESC
      Apply a new Mongrel configuration.
      DESC
      task :reset_config, :roles => :app do
        mongrel.cluster.stop
        run "rm -f #{mongrel_conf}"
        mongrel.cluster.setup
        mongrel.cluster.start
      end
    end
  end

  # Override standard deploy.
  namespace :deploy do
    desc <<-DESC
    Start the Mongrel processes on the app server by calling mongrel:cluster:start
    DESC
    task :start, :roles => :app do
      mongrel.cluster.start
    end

    desc <<-DESC
    Restart the Mongrel processes on the app server by calling mongrel:cluster:restart
    DESC
    task :restart, :roles => :app do
      mongrel.cluster.restart
    end

    desc <<-DESC
    Stop the Mongrel processes on the app server by calling mongrel:cluster:stop
    DESC
    task :stop, :roles => :app do
      mongrel.cluster.stop
    end
  end
end
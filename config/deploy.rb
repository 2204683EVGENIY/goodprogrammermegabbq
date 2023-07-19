# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "bbq_second"
set :repo_url, "git@github.com:2204683EVGENIY/goodprogrammermegabbq.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :branch, "main"

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

set :deploy_to, "/home/deploy/www"

after "deploy:restart", "resque:restart"

set :passenger_restart_with_touch, true

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key", "current/.env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
set :default_env, { path: "/home/deploy/.nvm/versions/node/v16.9.0/bin/:$PATH" }

# Default value for local_user is ENV["USER"]
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app) do
        unless test("[ -f .env ]")
          upload! '.env', ".env"
        end
      end
    end
  end
end

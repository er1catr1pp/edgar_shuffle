# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "edgar_shuffle"
set :repo_url, "git@github.com:er1catr1pp/edgar_shuffle.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/rails/edgar_shuffle'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# use capistrano-linked-files to transfer these securely to the prod server
# via 'bundle exec cap production linked_files:upload_files'
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# add common files to the shared folder
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# restart the passenger app on deploy
namespace :deploy do

  desc "Restart Passenger app"
  task :restart do
    on roles(:web) do |host|
      execute "mkdir -p #{fetch(:deploy_to)}/current/tmp"
        info "create folder #{fetch(:deploy_to)}/current/tmp"
        execute "touch #{fetch(:deploy_to)}/current/tmp/restart.txt"
      end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # upload linked files on each deployment
  before :finishing, 'linked_files:upload_files'

end
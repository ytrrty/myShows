lock '3.11'

set :application, 'shows'
set :repo_url, 'git@github.com:ytrrty/myShows.git'
set :deploy_to, '/home/ubuntu/shows'
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/puma.rb', 'config/master.key')
set :linked_dirs, fetch(:linked_dirs, []).push('tmp/pids', 'tmp/cache', 'tmp/sockets', 'log', 'public/system', 'node_modules')

set :config_example_suffix, '.example'
set :config_files, %w[config/database.yml config/master.key]
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_workers, 2
set :puma_threads, [8, 16]
set :puma_daemonize, true

namespace :deploy do
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  before 'deploy:migrate', 'deploy:db:create'
  after 'puma:smart_restart', 'nginx:restart'
end

task :setup do
  invoke 'ubuntu:setup'
  invoke 'puma:setup'
end

task :upload do
  invoke 'linked:upload'
end

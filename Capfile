require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/nginx'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require 'capistrano/rails'
require 'capistrano/rails/db'
require 'capistrano/upload-config'
require 'capistrano/scm/git'

install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx
install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

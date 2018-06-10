require './lib/capistrano/app/helpers'
include Capistrano::App::Helpers

namespace :puma do
  desc 'Setup puma'
  task :setup do
    on roles(:web) do
      as :root do
        execute :aptitude, '-y install nginx'
        execute :rm, '-f /etc/nginx/sites-available/default'
        sudo_upload! template('puma'), '/etc/init/puma.conf'
        sudo_upload! template('puma_manager'), '/etc/init/puma-manager.conf'

        # puma upstart
        execute :rm, '-f /etc/puma.conf'
        execute :echo, '/home/ubuntu/shows/current', '>', '/etc/puma.conf'
        execute :aptitude, '-y install upstart-sysv'
        execute 'update-initramfs', '-u'
      end
    end
  end
end

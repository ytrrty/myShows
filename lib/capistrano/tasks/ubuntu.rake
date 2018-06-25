ruby_setup = <<-SHELL
  wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz
  tar -xzvf ruby-2.5.0.tar.gz
  cd ruby-2.5.0/ && ./configure && make && sudo make install
  sudo gem install bundler
SHELL

namespace :ubuntu do
  desc 'Setup requirements'
  task :setup do
    on roles :app do
      as :root do
        sudo_upload! template('logrotate'), '/etc/logrotate.d/rails'
        execute 'apt-get', '-y install aptitude'
        execute 'add-apt-repository', 'ppa:nginx/stable -y'
        execute :aptitude, 'update'
        execute :curl, '-sL https://deb.nodesource.com/setup_6.x | sudo -E bash -'
        execute :aptitude, '-y install htop libgmp3-dev git libpq-dev postgresql-server-dev-9.5 nodejs git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev imagemagick'
        execute :npm, 'i -g pm2 coffee-script http-server yarn'
      end

      ruby_setup.split("\n").each do |command|
        execute command.strip if command.strip.length > 2
      end
    end
  end
end

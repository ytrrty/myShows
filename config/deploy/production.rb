server '52.232.110.252', user: 'ubuntu', roles: %w[app web db]
set :env, 'production'
set :branch, 'dev'
set :nginx_server_name, 'shows.pp.ua'

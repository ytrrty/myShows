# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

paths = %w[
  node_modules/bootstrap/dist/js
  node_modules/bootstrap/scss
  node_modules/jquery/dist
  node_modules/popper.js/dist/umd
  node_modules/rails-ujs/lib/assets/compiled
  node_modules/raty-js/lib
  node_modules
]

Rails.application.config.assets.paths += paths.map { |path| Rails.root.join(path) }

Rails.application.config.assets.precompile += %w[
  favorite.js
  filter.js
  seasons-list.js

  jquery.raty.js
  ratyrate.js
]

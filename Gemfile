source 'https://rubygems.org'
ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'
# Remove trailing slashes to prevent duplicate pages
gem 'rack-slashenforce'
# Use the Pure CSS framework
gem 'pure-css-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use Haml for clean markup
gem 'haml'
# Use jQuery as the JavaScript library
gem 'jquery-rails'
# Use Unicorn as our application server
gem 'unicorn'
# Use Block.io for processing transactions
gem 'block_io'
# Use Pusher for listening for transactions
gem 'pusher_rails'
# Use paperclip for file uploads
gem 'paperclip', '~> 4.2'
gem 'paperclip-compression'
# Use S3 for file storage
gem 'aws-sdk'

group :production do
  # Use PostgreSQL as the database
  gem 'pg'
  # Use Rails 12factor for Heroku logging
  gem 'rails_12factor'
end

group :development do
  # Keep the application running
  gem 'spring'
end

group :development, :test do
  # Use SQLite as the database
  gem 'sqlite3'
  # Use dotenv for environment variables
  gem 'dotenv-rails'
end

# bundle exec rake doc:rails generates the API under doc/api
gem 'sdoc', '~> 0.4.0', group: :doc
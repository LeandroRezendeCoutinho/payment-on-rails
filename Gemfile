source 'https://rubygems.org'

ruby '3.3.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

gem 'dotenv', '~> 2.8.1'
gem 'enumerize', '~> 2.5.0'
gem 'faraday', '~> 2.9.0'
gem 'hutch', '~> 1.2.0'
gem 'json-schema', '~> 4.1.1'
gem 'money-rails', '~> 1.15'
gem 'sidekiq', '~> 7.2.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails', '~> 6.4.3'
  gem 'rails-controller-testing'
  gem 'rbs'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop', '~> 1.60', require: false
  gem 'ruby-lsp', require: false
  gem 'ruby-lsp-rails'
  gem 'ruby-lsp-rspec', require: false
  gem 'shoulda-matchers', '~> 6.1'
  gem 'solargraph'
  gem 'steep'
end

group :development do
  gem 'annotate', '~> 3.2.0'
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'rspec-sidekiq', '~> 4.1.0'
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'webmock', '~> 3.20'
end

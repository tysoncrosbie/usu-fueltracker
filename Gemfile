source 'https://rubygems.org'

ruby '2.2.10'
gem 'rails', '4.2'

gem 'activeadmin',          '~> 1.0.0.pre5'
# gem 'activeadmin-extra',    git: 'https://github.com/stefanoverna/activeadmin-extra'

gem 'rails4-autocomplete',  '~> 1.1.0'
gem 'bourbon',              '~> 4.3', '>= 4.3.4'
gem 'bootstrap-sass',       '~> 3.1.1.1'
gem 'cancancan',            '~> 1.7'
gem 'chosen-rails'
gem 'coffee-rails',         '~> 4.0.0'
gem 'childprocess',         '~> 0.5'
gem 'devise'
gem 'formtastic',           '~> 3.1'
gem 'formtastic-bootstrap'
gem 'friendly_id',          '~> 5.0.0'
gem 'haml-rails'
gem 'jbuilder',             '~> 2.0'
gem 'jquery-rails'
gem 'jquery-ui-rails',      '~> 5.0'
gem 'pg'
gem 'pry'
gem 'rolify',               git: 'https://github.com/EppO/rolify'
gem 'state_machine',        '~> 1.2.0'
gem 'sqlite3',              '~> 1.3.6'
gem 'therubyracer'
gem 'turbolinks',           '~> 2.2.2'
gem 'uglifier',             '>= 1.3.0'


group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_20]
  gem 'foreman'
  gem 'html2haml',               '1.0.1'
  gem 'mailcatcher',             '~> 0.2.4'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
end


group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails',        '~> 3.8'
  gem 'faker',              '~> 1.3.0'
end


group :production do
  gem 'newrelic_rpm',               '~> 3.7.3.204'
  gem 'rack-timeout',               '~> 0.0.4'
  gem 'rails_12factor',             '~> 0.0.2'
  # gem 'rails_log_stdout',                           github: 'heroku/rails_log_stdout'
  # gem 'rails3_serve_static_assets',                 github: 'heroku/rails3_serve_static_assets'
  gem 'unicorn',                    '~> 4.8.2'
end


group :test do
  gem 'capybara'
  gem 'database_cleaner',    '~> 1.2.0'
  gem 'elabs_matchers',      '~> 0.0.6'
  gem 'email_spec',          '~> 1.5.0'
  gem "minitest"
  gem 'launchy',             '~> 2.4.2'
  gem 'selenium-webdriver',  '3.141.0'
  gem 'simplecov',           '~> 0.8.2', require: false
  gem 'puma'
  gem 'shoulda-matchers',    '~> 2.5.0'
end


# The heroku-api gem will not work.
# ‼️	You must instead use the platform-api gem.
# ‼️	The heroku-api gem communicated with the Legacy API which has been disabled.
# ‼️	https://devcenter.heroku.com/changelog-items/118

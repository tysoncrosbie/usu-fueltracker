source 'https://rubygems.org'

ruby '~> 2.5'
gem 'rails', '~> 4.2.11.3'

gem 'activeadmin',          '~> 1.4.3'
gem 'bootstrap-sass',       '~> 3.4.1'
gem 'bourbon',              '~> 7.0.0'
gem 'cancancan',            '~> 3.2.1'
gem 'childprocess',         '~> 0.9.0'
gem 'chosen-rails',         '~> 1.9.0'
gem 'coffee-rails',         '~> 4.2.2'
gem 'devise',               '~> 4.7.3'
gem 'formtastic',           '~> 3.1.5'
gem 'formtastic-bootstrap', '~> 3.1.1'
gem 'friendly_id',          '~> 5.4.2'
gem 'haml-rails',           '~> 1.0.0'
gem 'jbuilder',             '~> 2.9.1'
gem 'jquery-rails',         '~> 4.4.0'
gem 'jquery-ui-rails',      '~> 6.0.1'
gem 'pg',                   '~> 1.2.3'
gem 'pry',                  '~> 0.14.0'
gem 'rails4-autocomplete',  '~> 1.1.1'
gem 'rolify',               '~> 5.3.0'
gem 'sqlite3',              '~> 1.3.13'
gem 'state_machine',        '~> 1.2.0'
gem 'therubyracer',         '~> 0.12.3'
gem 'turbolinks',           '~> 5.2.0'
gem 'uglifier',             '~> 4.2.0'


group :development do
  gem 'better_errors',      '~> 2.9.1'
  gem 'binding_of_caller',  '~> 1.0.0', :platforms=>[:mri_20]
  gem 'foreman',            '~> 0.87.2'
  gem 'html2haml',          '~> 2.2.0'
  gem 'mailcatcher',        '~> 0.7.1'
  gem 'quiet_assets',       '~> 1.1.0'
  gem 'rails_layout',       '~> 1.0.42'
  gem 'spring',             '~> 2.1.1'
end


group :development, :test do
  gem 'factory_bot_rails',  '~> 5.2.0'
  gem 'rspec-rails',        '~> 4.1.2'
  gem 'faker',              '~> 2.2.1'
end

# TODO: saving prod for after rails 5 updgrade
group :production do
  gem 'newrelic_rpm',               '~> 3.7.3.204'
  gem 'rack-timeout',               '~> 0.0.4'
  gem 'rails_12factor',             '~> 0.0.2'
  # gem 'rails_log_stdout',                           github: 'heroku/rails_log_stdout'
  # gem 'rails3_serve_static_assets',                 github: 'heroku/rails3_serve_static_assets'
  gem 'unicorn',                    '~> 4.8.2'
  # # WARNING:
  # The heroku-api gem will not work.
  # ‼️	You must instead use the platform-api gem.
  # ‼️	The heroku-api gem communicated with the Legacy API which has been disabled.
  # ‼️	https://devcenter.heroku.com/changelog-items/118
end


group :test do
  gem 'capybara',            '~> 3.35.3'
  gem 'database_cleaner',    '~> 1.99.0'
  gem 'elabs_matchers',      '~> 2.0.0'
  gem 'email_spec',          '~> 2.2.0'
  gem 'minitest',            '~> 5.14.4'
  gem 'launchy',             '~> 2.5.0'
  gem 'selenium-webdriver',  '~> 3.142.7'
  gem 'simplecov',           '~> 0.21.2', require: false
  gem 'puma',                '~> 5.2.2'
  gem 'shoulda-matchers',    '~> 2.5.0'
end

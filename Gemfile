source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.1.1'

gem 'activeadmin',                     github: 'gregbell/active_admin'
gem 'activeadmin-extra',               github: 'stefanoverna/activeadmin-extra'

gem 'bootstrap-sass',     '~> 3.1.1.1'
gem 'cancancan',          '~> 1.7'
gem 'chosen-rails',       '~> 1.1.0'
gem 'coffee-rails',       '~> 4.0.0'
gem 'devise'
gem 'formtastic-bootstrap'
gem 'friendly_id',        '~> 5.0.0'
gem 'haml-rails'
gem 'jbuilder',           '~> 2.0'
gem 'jquery-rails'
gem 'jquery-ui-rails',    '~> 4.2.0'
gem 'pg'
gem 'rolify',                         github: 'EppO/rolify'
gem 'sass-rails',         '~> 4.0.3'
gem 'state_machine',      '~> 1.2.0'
gem "therubyracer"
gem 'turbolinks'
gem 'uglifier',           '>= 1.3.0'


group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_20]
  gem 'foreman'
  gem 'html2haml'
  gem 'mailcatcher',             '~> 0.2.4'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
end


group :development, :test do
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rspec-rails',        '~> 3.0.1'
  gem 'faker',              '~> 1.3.0'
end


group :production do
  gem 'newrelic_rpm',               '~> 3.7.3.204'
  gem 'rack-timeout',               '~> 0.0.4'
  gem 'rails_12factor',             '~> 0.0.2'
  # gem 'rails_log_stdout',                           github: 'heroku/rails_log_stdout'
  # gem 'rails3_serve_static_assets',                 github: 'heroku/rails3_serve_static_assets'
  gem 'unicorn',                    '~> 4.8.2'
  gem 'workless',                   '~> 1.2.2'
end


group :test do
  gem 'capybara',            '~> 2.3.0'
  gem 'database_cleaner',    '~> 1.2.0'
  gem 'elabs_matchers',      '~> 0.0.6'
  gem 'email_spec',          '~> 1.5.0'
  gem "minitest"
  gem 'launchy',             '~> 2.4.2'
  gem 'selenium-webdriver',  '~> 2.35.1'
  gem 'simplecov',           '~> 0.8.2', require: false
  gem 'shoulda-matchers',    '~> 2.5.0'
end

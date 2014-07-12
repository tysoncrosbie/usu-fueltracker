Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, switches: %w[--window-size=1024,1000 --disable-popup-blocking --ignore-certificate-errors --disable-translate --test-type] )
end

Capybara.configure do |config|
  config.match             = :prefer_exact
  config.javascript_driver = :chrome
  config.default_wait_time = 10
end

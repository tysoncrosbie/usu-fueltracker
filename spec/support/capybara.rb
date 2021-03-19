# Capybara.register_driver :chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: {
#       args: %w[headless window-size=1024,1000 disable-popup-blocking ignore-certificate-errors disable-translate test-type disable-gpu no-sandbox],
#     }
#   )
#
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :remote,
#     url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}",
#     desired_capabilities: capabilities
#   )
# end
Selenium::WebDriver.logger.level = Logger::DEBUG

Capybara.register_driver :chrome_headless do |app|
  chrome_capabilities = ::Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: %w[no-sandbox headless disable-gpu window-size=1400,1400] })

  if ENV['HUB_URL']
    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   url: ENV['HUB_URL'],
                                   desired_capabilities: chrome_capabilities)
  else
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   desired_capabilities: chrome_capabilities)
  end
end

Capybara.default_driver = :chrome_headless
Capybara.javascript_driver = :chrome_headless

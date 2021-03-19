RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller

  # config.include Devise::Test::IntegrationHelpers, type: :system
end

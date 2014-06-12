RSpec.configure do |config|
 config.include Warden::Test::Helpers

 Warden.test_mode!

 # config.after(:each) do
 #  Warden.test_reset!
 # end

end

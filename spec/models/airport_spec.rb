require 'rails_helper'

describe Airport do

  context 'validations' do
    it { should validate_presence_of(:faa_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:airport_name) }
  end

end
require 'rails_helper'

describe Plane do

  context 'validations' do
    it { should validate_presence_of(:tail_number) }
    it { should validate_presence_of(:plane_type) }
    it { should validate_uniqueness_of(:tail_number) }
  end

end
require 'rails_helper'

describe NonFuelCharge do

  context 'associations' do
    it { should belong_to(:receipt) }
  end

  context 'validations' do
    it { should validate_presence_of(:student_name) }
    it { should validate_presence_of(:charge_type) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
  end

end
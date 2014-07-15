require 'rails_helper'

describe Receipt do

  context 'associations' do
    it { should belong_to(:plane) }
    it { should have_many(:non_fuel_charges)}
  end

  context 'validations' do
    it { should validate_presence_of(:airport_id) }
    it { should validate_presence_of(:plane_id) }
    it { should validate_presence_of(:receipt_number) }
    it { should validate_presence_of(:receipt_date) }
    it { should validate_presence_of(:vendor_name) }
    it { should validate_presence_of(:gallons) }
    it { should validate_presence_of(:fuel_cost) }
    it { should validate_numericality_of(:gallons) }
    it { should validate_numericality_of(:fuel_cost) }
  end

end
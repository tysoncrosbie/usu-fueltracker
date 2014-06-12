 require 'rails_helper'

describe User do

  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email) }
    it { should ensure_length_of(:password).is_at_least(8).is_at_most(128) }
  end
end
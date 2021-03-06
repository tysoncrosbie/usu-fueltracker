require 'rails_helper'

describe 'Factory is valid' do
  FactoryGirl.factories.each do |factory|

    context "for #{factory.name}" do
      it { expect(build(factory.name)).to be_valid }
    end
  end
end

FactoryGirl.define do
  factory :plane do
    tail_number    { (rand(900) + 100).to_s + "N" }
    plane_type     { Faker::Name.first_name }
    fuel_type      { 'Jet Fuel'}

     trait :inactive do
      after(:create) { |r| r.inactivate! }
    end
  end
end

FactoryGirl.define do
  factory :receipt do
    receipt_number    { Faker::Name.name }
    receipt_date      { Time.now - 1.week }
    plane_id          { create(:plane).id }
    airport_id        { create(:airport).id }
    vendor_name       { Faker::Name.name }
    gallons           { rand(900) }
    fuel_cost         { (rand(900) + 100).to_s + "." + (rand(1000) / 10).to_s }

    trait :verified do
      after(:create) { |r| r.verify! }
    end

    trait :non_fuel_charge do
      non_fuel_charge_ids { create(:non_fuel_charge).id }
    end
  end
end

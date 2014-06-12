FactoryGirl.define do
  factory :non_fuel_charge do
    student_name    { Faker::Name.name }
    charge_type     { Faker::Name.name }
    amount          { (rand(900) + 100).to_s + "." + (rand(1000) / 10).to_s }

    trait :verified do
      after(:create) { |r| r.verify! }
    end
  end
end

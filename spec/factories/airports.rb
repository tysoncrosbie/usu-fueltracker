FactoryBot.define do
  factory :airport do
    airport_name        { Faker::Name.name }
    city                { Faker::Address.city }
    state               { Faker::Address.state_abbr }
    faa_code            { ('a'..'z').to_a.shuffle[0,4].join }
  end
end

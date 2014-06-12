FactoryGirl.define do
  factory :user do
    name            { Faker::Name.name }
    email           { Faker::Internet.email }
    password        { 'password' }

    ROLES.each do |role|
      factory role do
        after(:create) { |u,e| u.add_role(role) }
      end
    end
  end

end
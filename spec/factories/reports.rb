FactoryGirl.define do
  factory :report, class: 'Report' do
    name        { Faker::Name.name }
    starts_on   { Time.now - 1.week }
    ends_on     { Time.now + 1.week }
    type        { 'UsuEnvironmental' }
  end

  factory :usu_environmental, parent: :report, class: 'UsuEnvironmental' do
  end

  factory :utah_tap, parent: :report, class: 'UtahTap' do
  end

end

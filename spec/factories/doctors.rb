FactoryBot.define do
  factory :doctor do
    name { Faker::Name.name }
    specialization { Faker::Lorem.sentence(word_count: 2) }
    hospital_id nil
  end
end

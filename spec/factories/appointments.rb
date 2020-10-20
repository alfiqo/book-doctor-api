FactoryBot.define do
    factory :appointment do
        queue { Faker::Number.number }
        user_id { Faker::Number.within(range: 1..10) }
        doctor_id { Faker::Number.within(range: 1..10) }
    end
end

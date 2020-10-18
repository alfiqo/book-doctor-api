FactoryBot.define do
    factory :hospital do
      name { Faker::Lorem.word }
      address { Faker::Address.full_address }
    end
  end
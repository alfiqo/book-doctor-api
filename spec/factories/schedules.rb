FactoryBot.define do
  factory :schedule do
    schedule_day { Faker::Name.name }
    schedule_start Time.now
    schedule_finish Time.now
    doctor_id nil
  end
end

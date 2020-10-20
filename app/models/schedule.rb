class Schedule < ApplicationRecord
  belongs_to :doctor
  has_many :users, through: :appointments
  has_many :appointments

  validates_presence_of :schedule_day, :schedule_start, :schedule_finish
end

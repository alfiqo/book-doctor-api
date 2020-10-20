class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  validates_presence_of :queue, :user, :schedule
end

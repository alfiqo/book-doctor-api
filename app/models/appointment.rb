class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  validates_presence_of :queue, :user, :doctor
end

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  validates_presence_of :queue, :user, :schedule
  after_validation :validate_schedule_max

  private

  def validate_schedule_max
    errors.add(:schedule_id, "fully booked.") if self.schedule.appointments.count >= 10
  end
end

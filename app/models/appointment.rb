class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  validates_presence_of :queue, :user, :schedule
  after_validation :validate_schedule_max, :validate_schedule_time
  attr_accessor :length_of_book
  
  private

  def validate_schedule_max
    errors.add(:schedule_id, "fully booked.") if self.schedule.appointments.count >= 10
  end

  def length_of_book
    self.schedule.appointments.count
  end

  def validate_schedule_time
    start = Time.parse((self.schedule.schedule_start - 30.minutes).strftime("%H:%M:%S"))
    current = Time.parse((Time.now).strftime("%H:%M:%S"))
    errors.add(:schedule_id, "can't book within 30 minutes before the doctor starts the schedule.") unless (current < start)
  end
end

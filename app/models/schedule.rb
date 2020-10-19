class Schedule < ApplicationRecord
  belongs_to :doctor

  validates_presence_of :schedule_day, :schedule_start, :schedule_finish
end

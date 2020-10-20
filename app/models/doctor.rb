class Doctor < ApplicationRecord
  # model association
  belongs_to :hospital
  has_many :schedules, dependent: :destroy

  # validations
  validates_presence_of :name, :specialization
end

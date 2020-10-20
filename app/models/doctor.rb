class Doctor < ApplicationRecord
  # model association
  belongs_to :hospital
  has_many :schedules, dependent: :destroy
  has_many :users, through: :appointments
  has_many :appointments

  # validations
  validates_presence_of :name, :specialization
end

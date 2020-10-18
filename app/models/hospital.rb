class Hospital < ApplicationRecord
  # model association
  has_many :doctors, dependent: :destroy

  # validation
  validates_presence_of :name, :address
  validates_associated :doctors
end

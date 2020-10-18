class Doctor < ApplicationRecord
  # model association
  belongs_to :hospital

  # validations
  validates_presence_of :name, :specialization
end

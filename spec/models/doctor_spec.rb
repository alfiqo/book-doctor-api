require "rails_helper"

RSpec.describe Doctor, type: :model do
  # Association test
  it { should belong_to(:hospital) }
  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:specialization) }
end

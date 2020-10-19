require "rails_helper"

RSpec.describe Doctor, type: :model do
  # Association test
  it { should belong_to(:hospital) }
  it { should have_many(:schedules).dependent(:destroy) }
  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:specialization) }
end

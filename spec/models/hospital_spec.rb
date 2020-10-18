require "rails_helper"

RSpec.describe Hospital, type: :model do
  # Association test
  it { should have_many(:doctors).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
end

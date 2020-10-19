require "rails_helper"

RSpec.describe Schedule, type: :model do
  it { should belong_to(:doctor) }

  # Validation test
  it { should validate_presence_of(:schedule_day) }
  it { should validate_presence_of(:schedule_start) }
  it { should validate_presence_of(:schedule_finish) }
end

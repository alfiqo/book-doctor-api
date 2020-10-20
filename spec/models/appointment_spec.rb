require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:schedule) }
  it { should validate_presence_of(:queue) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:schedule) }
end

require "rails_helper"

RSpec.describe Person, type: :model do
  subject { build(:person) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_uniqueness_of(:first_name).scoped_to(:last_name) }
end

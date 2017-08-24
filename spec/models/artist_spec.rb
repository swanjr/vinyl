require 'active_record_helper'

require 'models/artist'

RSpec.describe Artist, type: :model do

  describe "associations" do
    it "should belong to many albums" do
      expect(described_class.reflect_on_association(:albums).macro).
        to eq(:has_many)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end

require 'active_record_helper'

require 'models/album'

RSpec.describe Album, type: :model do

  describe "associations" do
    it "should have many records" do
      expect(described_class.reflect_on_association(:records).macro).
        to eq(:has_many)
    end

    it "should have and belong to many artists" do
      expect(described_class.reflect_on_association(:artists).macro).
        to eq(:has_and_belongs_to_many)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_inclusion_of(:album_type).
         in_array(['album', 'single', 'compilation']) }
  end
end
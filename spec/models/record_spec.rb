require 'active_record_helper'

require 'models/record'

RSpec.describe Record, type: :model do

  describe "associations" do
    it "should belong to album" do
      expect(described_class.reflect_on_association(:album).macro).
        to eq(:belongs_to)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_inclusion_of(:condition).
         in_array(['M', 'NM', 'VG+', 'VG', 'G+', 'G', 'F', 'P']) }
  end
end

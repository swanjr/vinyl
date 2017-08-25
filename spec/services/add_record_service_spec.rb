require 'active_record_helper'

require 'models/record'
require 'models/album'

require 'services/add_record_service'

RSpec.describe AddRecordService do

  describe '#perform' do

    it "addeds the record to an existing album if there is one"  do
      existing_album = FactoryGirl.create(:album)   
      expect(existing_album.id).to_not be_nil
     
      parameters = {sides: "3,4", condition: 'P'}.
				merge!({album: existing_album.attributes.symbolize_keys()})
      record = described_class.new(parameters).perform

      expect(record.album.id).to eql(existing_album.id)
    end

    it "creates a new album if one does not exist" do
      parameters = {
        sides: "3,4", condition: 'P', album: { "title": "Best Hits", "album_type": "compilation"}}
      record = described_class.new(parameters).perform

      expect(record.album.id).to_not be_nil
    end

    it "creates a new record" do
      parameters = {
        sides: "3,4", condition: 'P', album: { "title": "Best Hits", "album_type": "compilation"}}
      record = described_class.new(parameters).perform

      expect(record.id).to_not be_nil
    end

    it "returns the record if a validation error occurs" do
      parameters = {
        sides: "3,4", condition: 'P', album: { "title": "Best Hits", "album_type": "fake_type"}}
      record = described_class.new(parameters).perform

      expect(record.id).to be_nil
      expect(record.condition).to eql("P")
      expect(record.album.title).to eql("Best Hits")
      expect(record.album.errors).to_not be_empty
    end
  end
end

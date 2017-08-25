require 'rails_helper'

RSpec.describe "Records API V1" do

  describe "POST#create" do
    let(:record_attrs) do 
			FactoryGirl.attributes_for(:record).
				merge({album: FactoryGirl.attributes_for(:album)})
		end

    let(:headers) { {"CONTENT_TYPE" => "application/json"} }

    context 'with valid data' do
      it "returns created submission" do
        post api_v1_records_path, params: record_attrs.to_json, headers: headers

        expect(response).to have_status(:created)
      end
    end

    context 'with invalid data' do
      it "returns an error message" do
        invalid_params = record_attrs
        invalid_params.delete(:condition)

        post api_v1_records_path, params: invalid_params.to_json, headers: headers

        expect(response).to have_status(:unprocessable_entity)
        expect(json['errors']).not_to be_empty
      end
    end
  end
end

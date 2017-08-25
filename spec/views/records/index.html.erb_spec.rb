require 'rails_helper'

RSpec.describe "records/index", type: :view do
  before(:each) do
    assign(:records, [
      FactoryGirl.create(:record),
      FactoryGirl.create(:record)
    ])
  end

  it "renders a list of records" do
    render
    assert_select "tr>td", :text => "Greatest Hits".to_s, :count => 2
    assert_select "tr>td", :text => "Album".to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "records/show", type: :view do
  before(:each) do
    @record = assign(:record, Record.create!(
      :sides => "Sides",
      :condition => "P"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sides/)
    expect(rendered).to match(/P/)
  end
end

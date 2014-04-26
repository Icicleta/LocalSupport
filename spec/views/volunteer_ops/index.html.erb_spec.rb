require 'spec_helper'

describe "volunteer_ops/index" do
  before(:each) do
    @org = stub_model(Organization, :name => "The Addams Family",  
                      :address => "666 Mockingbird Lane")
    @volunteer_ops = [(stub_model(VolunteerOp, :title => "Undertaker",
                      :description => "Help Uncle Fester", 
                      :organization => @org)),
                      (stub_model(VolunteerOp, :title => "Gravedigger",
                      :description => "Dispose of victims", 
                      :organization => @org))]
  end
  it "renders a list of volunteer_ops" do
    render
    @volunteer_ops.each do |op|
      rendered.should have_content op.title
      rendered.should have_content op.description
      rendered.should have_content op.organization.name
    end
  end

  it "renders a link to the volunteer_ops" do
    render
    @volunteer_ops.each do |op|
      rendered.should have_link op.title, :href => volunteer_op_path(op.id)
    end
  end

  it "renders a link to the organization" do
    render
    @volunteer_ops.each do |op|
      rendered.should have_link op.organization.name, :href => organization_path(op.organization.id)
    end
  end
  
  it "displays the javascript for a google map with a real call to Google" do
    org1 = stub_model(Organization)
    org2 =  stub_model(Organization)
    orgs = [org1, org2]
    assign(:json, orgs.to_gmaps4rails)
    render template: "volunteer_ops/index", layout: "layouts/application"
    rendered.should have_xpath "//script[contains(.,'Gmaps.map.map_options.auto_adjust = false')]"
    rendered.should have_xpath "//script[contains(.,'Gmaps.map.map_options.auto_zoom = true')]"
    rendered.should have_xpath "//script[contains(.,'Gmaps.map.map_options.center_latitude = 51.5978')]"
    rendered.should have_xpath "//script[contains(.,'Gmaps.map.map_options.center_longitude = -0.337')]"
    rendered.should have_xpath "//script[contains(.,'Gmaps.map.map_options.zoom = 12')]"
    rendered.should have_xpath "//script[contains(.,'Gmaps.map.map_options.auto_adjust = false')]"
  end

  # For the first pass of volunteer_ops the map popups are only
  # the organizations, not the actual volunteer_ops
  it "renders the popup partial" do
    render
    expect(response).to render_template(:partial => "_popup")
  end


end

require 'rails_helper'

RSpec.describe MeetupsController, type: :controller do

  describe "GET index" do
    it "assigns @meetups" do
      meetup1 = create(:meetup)
      meetup2 = create(:meetup)
      get :index
      expect(assigns[:meetups]).to eq([meetup1, meetup2])
    end

    it "render template" do
      meetup1 = create(:meetup)
      meetup2 = create(:meetup)

      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @meetup" do
      meetup = create(:meetup)
      get :show, params: { id: meetup.id }
      expect(assigns[:meetup]).to eq(meetup)
    end

    it "render template" do
      meetup = create(:meetup)
      get :show, params: { id: meetup.id }
      expect(response).to render_template("show")
    end
  end
end 

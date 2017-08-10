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

  describe "GET new" do
    context "when user login" do
      let(:user) { create(:user) }
      let(:meetup) { build(:meetup) }

      before do
        sign_in user
        get :new
      end

      it "assigns @meetup" do
        expect(assigns(:meetup)).to be_a_new(Meetup)
      end

      it "renders template" do
        expect(response).to render_template("new")
      end
    end

    context "when user not login" do
      it "redirect_to new_user_session_path" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end 

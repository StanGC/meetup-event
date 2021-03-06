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

  describe "POST create" do
    let(:user) { create(:user) }
    before { sign_in user }

    context "when meetup doesn't have title" do
      it "doesn't create a record" do
        expect do
          post :create, params: { meetup: { :description => "bar" }}
        end.to change { Meetup.count }.by(0)
      end

      it "render new template" do
        post :create, params: { meetup: { :description => "bar" } }

        expect(response).to render_template("new")
      end
    end

    context "when meetup has title" do
      it "create a new meetup record" do
        meetup = build(:meetup)

        expect do
          post :create, params: { meetup: attributes_for(:meetup) }
        end.to change { Meetup.count }.by(1)
      end

      it "redirects to meetups_path" do
        meetup = build(:meetup)

        post :create, params:{ meetup: attributes_for(:meetup) }

        expect(response).to redirect_to meetups_path
      end
    end
  end

  describe "GET edit" do
    let(:user) { create(:user) }
    before { sign_in user }

    it "assign meetup" do
      meetup = create(:meetup)

      get :edit , :id => meetup.id

      expect(assigns[:meetup]).to eq(meetup)
    end

    it "render template" do
      meetup = create(:meetup)

      get :edit , :id => meetup.id

      expect(response).to render_template("edit")
    end
  end

  describe "PUT update" do
    let(:user) { create(:user) }
    before { sign_in user }

    it "assign @meetup" do
      meetup = create(:meetup)

      put :update , params: { id: meetup.id, meetup: { title: "Title", description: "Description" } }

      expect(assigns[:meetup]).to eq(meetup)
    end

    it "changes value" do
      meetup = create(:meetup)

      put :update , params: { id: meetup.id, meetup: { title: "Title", description: "Description" } }

      expect(assigns[:meetup].title).to eq("Title")
      expect(assigns[:meetup].description).to eq("Description")
    end

    it "redirects to meetup_path" do
      meetup = create(:meetup)

      put :update , params: { id: meetup.id, meetup: { title: "Title", description: "Description" } }

      expect(response).to redirect_to meetup_path(meetup)
    end
  end

  describe "DELETE destroy" do
    let(:user) { create(:user) }
    before { sign_in user }

    it "assigns @meetup" do
      meetup = create(:meetup)

      delete :destroy, id: meetup.id

      expect(assigns[:meetup]).to eq(meetup)
    end

    it "deletes a record" do
      meetup = create(:meetup)

      expect { delete :destroy, id: meetup.id }.to change { Meetup.count }.by(-1)
    end

    it "redirects to meetups_path" do
      meetup = create(:meetup)

      delete :destroy, id: meetup.id

      expect(response).to redirect_to meetups_path
    end
  end
end 

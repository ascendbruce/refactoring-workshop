require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  describe "GET 'index'" do
    it "respend as success" do
      get :index
      expect(response).to be_success
    end

    context "admitted user" do
      let(:user) { User.find_by_email("admitted_user@example.com") }
      before { session[:user_id] = user.id }

      it "sets @projects as current_user's active_projects" do
        get :index
        expect(assigns(:projects)).to match_array user.active_projects
      end

      it "does not set flash message" do
        get :index
        expect(flash[:notice]).to be_blank
      end
    end

    context "new free tier user" do
      let(:user) { User.find_by_email("new_free_user@example.com") }
      before { session[:user_id] = user.id }

      it "sets @projects as featured projects" do
        get :index
        expect(assigns(:projects)).to match_array Project.featured
      end

      it "sets flash message" do
        get :index
        expect(flash[:notice]).to eq 'Upgrade and get 20% off for having your own projects!'
      end

    end

    context "old free tier user" do
      let(:user) { User.find_by_email("old_free_user@example.com") }
      before { session[:user_id] = user.id }

      it "sets @projects as featured projects" do
        get :index
        expect(assigns(:projects)).to match_array Project.featured
      end

      it "sets flash message" do
        get :index
        expect(flash[:notice]).to eq 'Upgrade for having your own projects!'
      end
    end

    context "guest" do
      it "sets @projects as featured projects" do
        get :index
        expect(assigns(:projects)).to match_array Project.featured
      end

      it "does not set flash message" do
        get :index
        expect(flash[:notice]).to be_blank
      end
    end
  end

  describe "PUT 'update" do
    let(:is_featured) { false }
    let(:project)     { Project.find_by_title("Project A") }
    let(:params)      { { id: project.id, title: "", description: "", is_featured: is_featured, label: "normal" } }

    it "redirects to project path with valid inputs" do
      put :update, id: project.id, project: params
      expect(response).to redirect_to project_path(project)
    end

    context "new project, featured" do
      let(:is_featured) { true }

      it "updates the label to 'new featured'" do
        put :update, id: project.id, project: params
        project.reload
        expect(project.label).to eq "new featured"
      end
    end

    context "old project, featured" do
      let(:is_featured) { true }

      it "updates the label to 'new featured'" do
        project.update_column(:created_at, 2.weeks.ago)
        put :update, id: project.id, project: params
        project.reload
        expect(project.label).to eq "featured"
      end
    end

    context "normal project" do
      let(:project)     { Project.create(title: 'Project D', description: 'Featured Project', label: 'new featured', is_featured: true) }
      let(:is_featured) { false }

      it "updates the label to 'new featured'" do
        put :update, id: project.id, project: params
        project.reload
        expect(project.label).to eq "normal"
      end
    end
  end
end

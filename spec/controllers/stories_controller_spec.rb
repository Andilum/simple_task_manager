require 'spec_helper' 

describe StoriesController do 
  let(:user) { FactoryGirl.create(:user) }
  before {sign_in user}


  describe "GET #index" do
    let(:story) { FactoryGirl.create(:story, user: user) }
    it "can GET 'index'" do
      get :index
      response.should be_success
    end

    it "populates an array of stories" do
      post :index, :q => {author_id_eq: "", responsible_user_id_eq: "", state_eq: ""}
      expect(assigns(:stories)).to eq([story])
    end

    it "redirect to :index"  do
      get :index, :q => {author_id_eq: "", responsible_user_id_eq: "", state_eq: ""}
      response.should render_template(:index)
    end  
  end 

  describe "GET #show" do
    let(:story) { FactoryGirl.create(:story, user: user) }
    it "can GET 'show'" do
      get :show, id: story
      response.should be_success
    end

    it "populates an array of stories" do
      get :show, id: story 
      expect(assigns(:story)).to eq(story)
    end

    it "redirect to :show"  do
      get :show, id: story 
      response.should render_template(:show)
    end
   
  end 

  describe "GET #new" do 
    it "can GET 'new'" do
      get :new
      response.should be_success
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end 
   
  end 

  describe "POST #create" do 
    context "with valid attributes" do
      it "creates a new story" do 
        expect{ 
          post :create, story: FactoryGirl.attributes_for(:story, user: user) 
        }.to change(Story,:count).by(1)
      end
      it "redirects to the new story" do
        post :create, story: FactoryGirl.attributes_for(:story, user: user)
        response.should redirect_to Story.last
      end

      it "show flash message" do
        post :create, story: FactoryGirl.attributes_for(:story, user: user)
        flash[:success].should_not be_nil
      end
    end 

    context "with invalid attributes" do 
      it "does not save the new contact" do 
        expect{ 
          post :create, story: FactoryGirl.attributes_for(:invalid_story, user: user)
        }.to_not change(Story,:count)
      end
      it "re-renders the new method" do
        post :create, story: FactoryGirl.attributes_for(:invalid_story, user: user)
        response.should render_template :new
      end 
    end 
  end

  describe "PUT #update" do 
    let(:story) { FactoryGirl.create(:story, title: "My best story", description: "The best of the best", 
                                               state: "new", user: user) }

    context "with valid attributes" do
      it "located the requested story" do 
        put :update, id: story, story: FactoryGirl.attributes_for(:story, user: user)
        assigns(:story).should eq(story)
      end
      it "changes stories's attributes" do
        put :update, id: story, 
          story: FactoryGirl.attributes_for(:story, title: "My worse story", description: "The worse of the worse", 
                                             state: "new", user: user)
        story.reload
        story.title.should eq("My worse story")
        story.description.should eq("The worse of the worse")
      end
      it "redirects to the updated story" do
        put :update, id: story, story: FactoryGirl.attributes_for(:story, user: user)
        response.should redirect_to story
      end

      it "show flash message" do
        put :update, id: story, story: FactoryGirl.attributes_for(:story, user: user)
        flash[:success].should_not be_nil
      end
    end 

    context "with invalid attributes" do 
      it "located the requested story" do 
        put :update, id: story, story: FactoryGirl.attributes_for(:invalid_story, user: user)
        assigns(:story).should eq(story)
      end
      it "does not changes stories's attributes" do
        put :update, id: story, 
          story: FactoryGirl.attributes_for(:story, title: nil, description: "The worse of the worse", 
                                             state: "new", user: user)
        story.reload
        story.title.should eq("My best story")
        story.description.should eq("The best of the best")
      end
      it "re-renders the show " do
        put :update, id: story, story: FactoryGirl.attributes_for(:invalid_story, user: user)
        response.should render_template :show
      end
    end 

  end

  describe "DELETE #destroy" do 
    let!(:story) { FactoryGirl.create(:story, user: user) }
    it "delete the story"  do
      expect{
        delete :destroy, id: story
      }.to change(Story, :count).by(-1)
    end

    it "show flash message" do
      delete :destroy, id: story
      flash[:success].should_not be_nil
    end

    it "redirects to user" do
      delete :destroy, id: story
      response.should redirect_to user
    end
 
  end

end
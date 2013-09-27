require 'spec_helper' 

describe StoryCommentsController do 
  let(:user) { FactoryGirl.create(:user) }
  before {sign_in user} 


  describe "POST #create" do
    let!(:story) { FactoryGirl.create(:story, user: user) }
    context "with valid attributes" do
      it "creates a new story_comment" do 
        expect{ 
          post :create, story_comment:  {content: "Trololo!", user_id: user.id , story_id: story.id}
        }.to change(StoryComment, :count).by(1)
      end
      it "redirects to the comment story" do
        post :create, story_comment: {content: "Trololo!", user_id: user.id , story_id: story.id}
        response.should redirect_to story
      end

      it "show flash message" do
        post :create, story_comment: {content: "Trololo!", user_id: user.id , story_id: story.id}
        flash[:success].should_not be_nil
      end
    end 

    context "with invalid attributes" do 
      it "does not save the new contact" do 
        expect{ 
          post :create, story_comment: {content: "", user_id: user.id , story_id: story.id}
        }.to_not change(StoryComment,:count)
      end
      it "re-renders the show method" do
        post :create, story_comment: {content: "", user_id: user.id , story_id: story.id} 
        response.should render_template :show
      end 
    end 
  
  end


  describe "DELETE #destroy" do 
    let!(:story) { FactoryGirl.create(:story, user: user) }
    let!(:story_comment) { FactoryGirl.create(:story_comment, user: user, story: story) }
    it "delete the story_comment"  do
      expect{
        delete :destroy, id: story_comment
      }.to change(StoryComment, :count).by(-1)
    end

    it "show flash message" do
      delete :destroy, id: story_comment
      flash[:success].should_not be_nil
    end

    it "redirects to story" do
      delete :destroy, id: story_comment
      response.should redirect_to story
    end 
  end
 
end
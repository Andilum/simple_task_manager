require 'spec_helper' 

describe SessionsController do 


  describe "GET #new" do 
    it "can GET 'new'" do
      get :new
      response.should be_success
    end 
  end 

  describe "POST #create" do 
    let!(:user) { FactoryGirl.create(:user, name: "Lawrence Smith", email: "l_smith@example.com", 
                                  password: "foobar", password_confirmation: "foobar") }
    context "with valid attributes" do
      it "assigns the session user to user"  do
        post :create, :session => { email: "l_smith@example.com", password: "foobar"}
        assigns(:user).should eq(user)    
      end

      it "redirect to user"  do
        post :create, :session => { email: "l_smith@example.com", password: "foobar"}
        response.should redirect_to user    
      end
    end 

    context "with invalid attributes" do
      it "redirect to :new"  do
        post :create, :session => { email: "l_west@example.com", password: "pass"}
        response.should render_template(:new)
      end

      it "show flash message" do
        post :create, :session => { email: "l_west@example.com", password: "pass"}
        flash[:error].should_not be_nil
      end
    end 
  end



  describe "DELETE #destroy" do
    it "redirects to root_url" do
      delete :destroy
      response.should redirect_to root_url
    end 
  end

end
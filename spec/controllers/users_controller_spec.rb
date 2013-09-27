require 'spec_helper' 

describe UsersController do 
  let(:user) { FactoryGirl.create(:user) }
  before {sign_in user}


  describe "GET #index" do
    it "populates an array of users" do
    	get :index 
    	expect(assigns(:users)).to eq([user])
    end	

    it "can GET 'index'" do
      get :index
      response.should be_success
    end

    it "renders the :index template" do
      get :index 
      expect(response).to render_template(:index)
    end
  end 

  describe "GET #show" do
    let(:story) { FactoryGirl.create(:story, user: user) }
    it "assigns the requested user to user"  do
    	get :show, id: user
    	assigns(:user).should eq(user)    
    end

    it "assigns the @stories to story"  do
      get :show, id: user
      assigns(:stories).should eq([story])    
    end

    it "can GET 'show'" do
      get :show, id: user
      response.should be_success
    end

    it "renders the :show template" do
      get :show, id: user
      expect(response).to render_template(:show)
    end 
  end 

  describe "GET #new" do 
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end 
  end 

  describe "POST #create" do 
    context "with valid attributes" do
      it "creates a new user" do 
      	expect{ 
      		post :create, user: FactoryGirl.attributes_for(:user) 
      	}.to change(User,:count).by(1)
      end
      it "redirects to the new user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to User.last
      end

      it "show flash message" do
        post :create, user: FactoryGirl.attributes_for(:user)
        flash[:success].should_not be_nil
      end
    end 

    context "with invalid attributes" do 
      it "does not save the new contact" do 
      	expect{ 
      		post :create, user: FactoryGirl.attributes_for(:invalid_user) 
      	}.to_not change(User,:count)
      end
      it "re-renders the new method" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        response.should render_template :new
      end 
    end 
  end

  describe "POST #edit" do 
    it "renders the :edit template" do
      post :edit, id: user
      expect(response).to render_template(:edit)
    end 
  end 

  describe "PUT #update" do 

  	let(:user) { FactoryGirl.create(:user, name: "Lawrence Smith", email: "l_smith@example.com", 
  		                            password: "foobar", password_confirmation: "foobar") }

    context "with valid attributes" do
      it "located the requested user" do 
      	put :update, id: user, user: FactoryGirl.attributes_for(:user)
      	assigns(:user).should eq(user)
      end
      it "changes user's attributes" do
        put :update, id: user, 
          user: FactoryGirl.attributes_for(:user, name: "Larry West", email: "l_west@example.com",
                                            password: "foobar", password_confirmation: "foobar")
        user.reload
        user.name.should eq("Larry West")
        user.email.should eq("l_west@example.com")
        user.password.should eq("foobar")
        user.password_confirmation.should eq("foobar")
      end
      it "redirects to the updated user" do
      	put :update, id: user, user: FactoryGirl.attributes_for(:user)
      	response.should redirect_to user
      end

      it "show flash message" do
        put :update, id: user, user: FactoryGirl.attributes_for(:user)
        flash[:success].should_not be_nil
      end
    end 

    context "with invalid attributes" do 
      it "located the requested user" do 
      	put :update, id: user, user: FactoryGirl.attributes_for(:invalid_user)
      	assigns(:user).should eq(user)
      end

      it "does not changes user's attributes" do
        put :update, id: user, 
          user: FactoryGirl.attributes_for(:user, name: "Larry West", email: nil,
                                            password: "foobar", password_confirmation: "foobar")
        user.reload
        user.name.should_not eq("Larry West")
        user.email.should eq("l_smith@example.com")
        user.password.should eq("foobar")
        user.password_confirmation.should eq("foobar")
      end

      it "re-renders the edit method" do
      	put :update, id: user, user: FactoryGirl.attributes_for(:invalid_user)
      	response.should render_template :edit
      end
    end 
  end

  describe "DELETE #destroy" do 
  	let(:admin) { FactoryGirl.create(:admin) }
    before {sign_in admin}

    it "delete the user"  do
    	expect{
    	  delete :destroy, id: user
    	}.to change(User, :count).by(-1)
    end

    it "show flash message" do
      delete :destroy, id: user
      flash[:success].should_not be_nil
    end

    it "redirects to users#index" do
      delete :destroy, id: user
      response.should redirect_to users_url
    end
  end

end
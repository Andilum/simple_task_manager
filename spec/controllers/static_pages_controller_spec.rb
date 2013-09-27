require 'spec_helper'

describe StaticPagesController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET #home" do
  	it "can GET 'home'" do
      get :home
      response.should be_success
    end

  	context "with logged user" do
  	  before {sign_in user}
      it "redirects to user page" do
        get :home
        response.should redirect_to user
      end
    end

    context "with guest user" do
      it "renders the :home template" do
        get :home
        response.should render_template :home
      end
    end
  end

  describe "GET #help" do
  	it "can GET 'help'" do
      get :help
      response.should be_success
    end

  	it "renders the :help template" do
      get :help
      response.should render_template :help
    end
  end

  describe "GET #about" do
  	it "can GET 'about'" do
      get :about
      response.should be_success
    end

  	it "renders the :about template" do
      get :about
      response.should render_template :about
    end
  end

  describe "GET #contact" do
  	it "can GET 'contact'" do
      get :contact
      response.should be_success
    end

  	it "renders the :contact template" do
      get :contact
      response.should render_template :contact
    end
  end

end
require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
    
  end
  
  describe "POST 'create'" do
    
    describe "invalid signin" do
      before(:each) do 
        @attr = {:email => "", :password => ""}
      end
    
      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
      
      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")
      end
      
      it "should render the new template" do
        post :create, :session => @attr
        response.should render_template('new')
      end
    end
    
    describe "valid email and passsword" do
      before(:each) do
        @user = Factory(:user)
        @attr = {:email => @user.email, :password => @user.password}
      end
      
      it "should redirect to the users page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
    end
  end
  
  describe "DELETE 'destory'" do
    it "should sign the user out" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
  
  describe "As a signed in user" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @attr = {:email => @user.email, :password => @user.password}
    end
    
    describe "when accessing new" do
      it "should redirect to the root page" do
        get :new
        response.should redirect_to(root_path)
      end
    end
    
    describe "when accessing create" do
      it "should redirect to the root page" do
        post :create, :session => @attr
        response.should redirect_to(root_path)
      end
    end
  end
end

require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector("title", :content => "Home")
  end
  
  it "should have an About page at '/About'" do
    get '/about'
    response.should have_selector("title", :content => "About")
  end
  
  it "should have a Contact page at '/Contact'" do
    get '/contact'
    response.should have_selector("title", :content => "Contact")
  end
  
  it "should have a Help page at '/Help'" do
    get '/help'
    response.should have_selector("title", :content => "Help")
  end
  
  it "should have a Signup page at '/Signup'" do
    get 'signup'
    response.should have_selector("title", :content => "Sign up")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign Up Now!"
    response.should have_selector('title', :content => "Sign up")
  end
  
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :content => "Sign in", :href => signin_path)
    end
  end
  
  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end
    
    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :content => "Sign out", :href => signout_path)
    end
    
    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :content => "Profile", :href => user_path(@user))
    end
  end
end

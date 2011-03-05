require 'spec_helper'

describe "FriendlyForwardings" do
  
  it "should forward to requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)
    #test follows the redirection to the signin page
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
    #should redirect to the users original request
    response.should render_template('users/edit')
  end
end

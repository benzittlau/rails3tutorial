require 'spec_helper'

describe RelationshipsController do

  describe "access control" do
    
    it "should protect the 'create' action" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should protect the 'delete' action" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @followed = Factory(:user, :email => Factory.next(:email))
    end
    
    it "should create a relationship" do
      lambda do
        post :create, :relationship => { :followed_id => @followed.id }
      end.should change(Relationship, :count).by(1)
    end
    
    it "should create a relationship via ajax" do
      lambda do
        xhr :post, :create, :relationship => { :followed_id => @followed.id }
        response.should be_success
      end.should change(Relationship, :count).by(1)
    end
  end
  
  describe "DELETE 'destory'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @followed = Factory(:user, :email => Factory.next(:email))
      @user.follow!(@followed)
      @relationship = @user.relationships.find_by_followed_id(@followed.id)
    end
    
    it "should delete a relationship" do
      lambda do
        delete :destroy, :id => @relationship.id
        response.should be_redirect
      end.should change(Relationship, :count).by(-1)
    end
    
    it "should delete a relationship via ajax" do
      lambda do
        xhr :delete, :destroy, :id => @relationship.id
        response.should be_success
      end.should change(Relationship, :count).by(-1)
    end
  end
end

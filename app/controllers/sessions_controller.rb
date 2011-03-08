class SessionsController < ApplicationController
  before_filter :not_signed_in, :only => [:new, :create]
  
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  private
  
    def not_signed_in
      redirect_to root_path if signed_in?
    end

end

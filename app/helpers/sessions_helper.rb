module SessionsHelper
  def sign_in(user)
    session[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    session[:remember_token] = nil
    self.current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    current_user == user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to (session[:stored_location] || default)
    clear_stored_location
  end
  
  private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      session[:remember_token] || [nil,nil]
    end
    
    def store_location
      session[:stored_location] = request.fullpath
    end
    
    def clear_stored_location
      session[:stored_location] = nil
    end
end

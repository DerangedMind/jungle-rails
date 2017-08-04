class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) 
    end
  end
  helper_method :current_user

  
  def admin?
    current_user && current_user.admin
  end
  helper_method :admin?

  def authorize
    redirect_to '/login' unless current_user
  end

  def authorize_admin
    flash[:error] = 'This is not the page you were looking for.'
    redirect_to '/' unless admin?
    false
  end


  private

  def cart
    # value = cookies[:cart] || JSON.generate({})
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

end

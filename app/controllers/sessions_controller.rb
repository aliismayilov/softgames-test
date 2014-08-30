class SessionsController < ApplicationController
  skip_before_filter :save_return_path

  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_with_omniauth(auth)

    session[:user_id] = user.id

    redirect_to picasa_path
  end

  def failure
    redirect_to root_path, alert: 'You did not succeed. Please try again.'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, alert: 'You have successfully signed out.'
  end
end

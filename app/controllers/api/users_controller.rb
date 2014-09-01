class Api::UsersController < Api::ApiController
  respond_to :json

  def show
    respond_with current_user, except: :oauth_token
  end
end

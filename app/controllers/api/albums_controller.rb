class Api::AlbumsController < Api::ApiController
  respond_to :json

  def index
    picasa_request
  end

  def show
    picasa_request(path: "albumid/#{params[:id]}")
  end

  private
    def current_user
      authenticate_with_http_token do |token, options|
        @current_user ||= User.find_by(app_token: token)
      end
    end
end

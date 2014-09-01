class Api::AlbumsController < Api::ApiController
  respond_to :json
  before_filter :authenticate!

  def index
    picasa_request
  end

  def show
    picasa_request "albumid/#{params[:id]}"
  end

  private
    def current_user
      authenticate_or_request_with_http_token do |token, options|
        @current_user ||= User.find_by(token: token)
      end
    end
end

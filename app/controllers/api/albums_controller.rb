class Api::AlbumsController < Api::ApiController
  respond_to :json
  before_filter :authenticate!

  def index
    RestClient.get(
      'https://picasaweb.google.com/data/feed/api/user/default',
      {
        params: { alt: 'json' },
        authorization: "Bearer #{current_user.token}"
      }
    ) do |response|
      case response.code.to_s
      when /^2/
        render json: response.body, status: response.code
      else
        render text: response.body, status: response.code
      end
    end
  end

  def show
    RestClient.get(
      "https://picasaweb.google.com/data/feed/api/user/default/albumid/#{params[:id]}",
      {
        params: { alt: 'json' },
        authorization: "Bearer #{current_user.token}"
      }
    ) do |response|
      case response.code.to_s
      when /^2/
        render json: response.body, status: response.code
      else
        render text: response.body, status: response.code
      end
    end
  end

  private
    def current_user
      authenticate_or_request_with_http_token do |token, options|
        @current_user ||= User.find_by(token: token)
      end
    end
end

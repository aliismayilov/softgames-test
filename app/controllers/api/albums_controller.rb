class Api::AlbumsController < Api::ApiController
  respond_to :json
  before_filter :authenticate!

  def index
    response = RestClient.get(
      'https://picasaweb.google.com/data/feed/api/user/default',
      {
        params: { alt: 'json' },
        authorization: "Bearer #{current_user.token}"
      }
    )
    render json: response.body, status: response.code
  end
end

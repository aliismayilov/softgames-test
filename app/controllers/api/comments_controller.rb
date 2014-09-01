class Api::CommentsController < Api::ApiController
  respond_to :json
  before_filter :authenticate!

  def create
    RestClient.post(
      "https://picasaweb.google.com/data/feed/api/user/default/albumid/#{comment_params[:album_id]}/photoid/#{comment_params[:photo_id]}",
      "<entry xmlns=\"http://www.w3.org/2005/Atom\"><content>#{comment_params[:content]}</content><category scheme=\"http://schemas.google.com/g/2005#kind\" term=\"http://schemas.google.com/photos/2007#comment\"/></entry>",
      {
        content_type: 'application/atom+xml; charset=UTF-8; type=entry',
        authorization: "Bearer #{current_user.token}"
      }
    ) do |response|
      case response.code.to_s
      when /^2/
        render json: Hash.from_xml(response.body).to_json, status: response.code
      else
        render text: response.body, status: response.code
      end
    end
  end

  def index
    RestClient.get(
      "https://picasaweb.google.com/data/feed/api/user/default/albumid/#{params[:album_id]}/photoid/#{params[:photo_id]}",
      {
        params: { alt: 'json', kind: 'comment' },
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
    def comment_params
      params.require(:comment).permit(:album_id, :photo_id, :content)
    end

    def current_user
      authenticate_or_request_with_http_token do |token, options|
        @current_user ||= User.find_by(token: token)
      end
    end
end

class Api::CommentsController < Api::ApiController
  respond_to :json

  def create
    data = "<entry xmlns=\"http://www.w3.org/2005/Atom\"><content>#{comment_params[:content]}</content><category scheme=\"http://schemas.google.com/g/2005#kind\" term=\"http://schemas.google.com/photos/2007#comment\"/></entry>"
    picasa_request(path: "albumid/#{params[:album_id]}/photoid/#{params[:photo_id]}", method: :post, data: data)
  end

  def index
    picasa_request(path: "albumid/#{params[:album_id]}/photoid/#{params[:photo_id]}")
  end

  def destroy
    picasa_request(url: params[:url].split('?').first, method: :delete)
  end

  private
    def comment_params
      params.require(:comment).permit(:album_id, :photo_id, :content)
    end

    def current_user
      authenticate_with_http_token do |token, options|
        @current_user ||= User.find_by(app_token: token)
      end
    end
end

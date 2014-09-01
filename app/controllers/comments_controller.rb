class CommentsController < ApplicationController
  respond_to :json
  before_filter :authenticate!

  def create
    response = RestClient.post(
      "https://picasaweb.google.com/data/feed/api/user/default/albumid/#{comment_params[:album_id]}/photoid/#{comment_params[:photo_id]}?access_token=#{current_user.token}",
      "<entry xmlns=\"http://www.w3.org/2005/Atom\"><content>#{comment_params[:content]}</content><category scheme=\"http://schemas.google.com/g/2005#kind\" term=\"http://schemas.google.com/photos/2007#comment\"/></entry>",
      { content_type: 'application/atom+xml; charset=UTF-8; type=entry' }
    )
    head response.code
  end

  private
    def comment_params
      params.require(:comment).permit(:album_id, :photo_id, :content)
    end
end

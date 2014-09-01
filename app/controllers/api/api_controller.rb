class Api::ApiController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :authenticate!

  protected
    def picasa_request(path='', method=:get, data=nil)
      base_url = 'https://picasaweb.google.com/data/feed/api/user/default'
      url = "#{base_url}/#{path}"
      if method == :get
        response = RestClient.get(
          url,
          {
            params: { alt: 'json' },
            authorization: "Bearer #{current_user.oauth_token}"
          }
        )
        render json: response.body, status: response.code
      elsif method == :post
        begin
          response = RestClient.post(
            url,
            data,
            {
              content_type: 'application/atom+xml; charset=UTF-8; type=entry',
              authorization: "Bearer #{current_user.oauth_token}"
            }
          )
          render json: Hash.from_xml(response.body).to_json, status: response.code
        rescue => e
          render text: e.response.body, status: e.response.code
        end
      else
        head :bad_request
      end
    end
end

class Api::ApiController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :authenticate!

  protected
    def picasa_request(url: nil, path: nil, method: :get, data: nil)
      base_url = 'https://picasaweb.google.com/data/feed/api/user/default'
      url = url || "#{base_url}/#{path}"
      begin
        if method == :get || method == :delete
          response = RestClient.send(method,
            url,
            {
              params: { alt: 'json' },
              authorization: "Bearer #{current_user.oauth_token}"
            }
          )
          render json: response.body, status: response.code
        elsif method == :post
          response = RestClient.post(
            url,
            data,
            {
              content_type: 'application/atom+xml; charset=UTF-8; type=entry',
              authorization: "Bearer #{current_user.oauth_token}"
            }
          )
          render json: Hash.from_xml(response.body).to_json, status: response.code
        else
          head :bad_request
        end
      rescue => e
        render text: e.response.body, status: e.response.code
      end
    end
end

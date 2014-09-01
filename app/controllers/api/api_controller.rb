class Api::ApiController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
    def picasa_request(path='', method=:get, data=nil)
      base_url = 'https://picasaweb.google.com/data/feed/api/user/default'
      url = "#{base_url}/#{path}"
      if method == :get
        RestClient.get(url,
          {
            params: { alt: 'json' },
            authorization: "Bearer #{current_user.token}"
          }
        ) do |response|
          render json: response.body, status: response.code
        end
      elsif method == :post
        RestClient.post(
          url,
          data,
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
    end
end

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true
  validates :app_token, presence: true, uniqueness: true
  before_validation :set_app_token, on: :create

  def self.find_or_create_with_omniauth(auth)
    user = self.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.update({
      name:             auth['info']['name'],
      email:            auth['info']['email'],
      image:            auth['info']['image'],
      oauth_token:      auth['credentials']['token'],
      token_expires_at: Time.at(auth['credentials']['expires_at'])
    })

    user
  end

  private
    def set_app_token
      return if app_token.present?
      self.app_token = generate_app_token
    end

    def generate_app_token
      loop do
        token = SecureRandom.hex(32)
        break token unless self.class.exists?(app_token: token)
      end
    end
end

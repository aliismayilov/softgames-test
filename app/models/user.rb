class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true

  def self.find_or_create_with_omniauth(auth)
    user = self.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.update({
      name:             auth['info']['name'],
      email:            auth['info']['email'],
      image:            auth['info']['image'],
      token:            auth['credentials']['token'],
      token_expires_at: Time.at(auth['credentials']['expires_at'])
    })

    user
  end
end

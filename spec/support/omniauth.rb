RSpec.configure do |config|
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => "google_oauth2",
    :uid => "123456789",
    :info => {
      :name => "John Doe",
      :email => "john@company_name.com",
      :first_name => "John",
      :last_name => "Doe",
      :image => "https://lh3.googleusercontent.com/url/photo.jpg"
    },
    :credentials => {
      :token => "token",
      :refresh_token => "another_token",
      :expires_at => 1354920555,
      :expires => true
    },
    :extra => {
      :raw_info => {
        :sub => "123456789",
        :email => "user@domain.example.com",
        :email_verified => true,
        :name => "John Doe",
        :given_name => "John",
        :family_name => "Doe",
        :profile => "https://plus.google.com/123456789",
        :picture => "https://lh3.googleusercontent.com/url/photo.jpg",
        :gender => "male",
        :birthday => "0000-06-25",
        :locale => "en",
        :hd => "company_name.com"
      }
    }
  })
end

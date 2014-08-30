require 'rails_helper'

RSpec.describe User, :type => :model do
  describe '.find_or_create_with_omniauth' do
    let(:auth) do
      {
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
        }
      }.with_indifferent_access
    end

    context 'user does not exist' do
      describe 'creating a new user' do
        it 'creates a new user' do
          expect {
            User.find_or_create_with_omniauth(auth)
          }.to change{ User.count }.by(1)
        end
      end

      describe 'setting data on new user' do
        subject(:user) { User.find_or_create_with_omniauth(auth) }

        it { expect(user.provider).to eql 'google_oauth2' }
        it { expect(user.uid).to eql '123456789' }
        it { expect(user.name).to eql 'John Doe' }
        it { expect(user.email).to eql 'john@company_name.com' }
        it { expect(user.image).to eql 'https://lh3.googleusercontent.com/url/photo.jpg' }
        it { expect(user.token).to eql 'token' }
      end
    end

    context 'user already exists' do
      let!(:existing_user) do
        create(:user, provider: 'google_oauth2', uid: '123456789')
      end

      describe 'finding existing user' do
        it { expect(User.find_or_create_with_omniauth(auth)).to eql existing_user }
        it { expect{ User.find_or_create_with_omniauth(auth) }.not_to change{ User.count } }
      end

      describe 'updating existing user' do
        before do
          User.find_or_create_with_omniauth(auth)
          existing_user.reload
        end

        it { expect(existing_user.provider).to eql 'google_oauth2' }
        it { expect(existing_user.uid).to eql '123456789' }
        it { expect(existing_user.name).to eql 'John Doe' }
        it { expect(existing_user.email).to eql 'john@company_name.com' }
        it { expect(existing_user.image).to eql 'https://lh3.googleusercontent.com/url/photo.jpg' }
        it { expect(existing_user.token).to eql 'token' }
      end
    end
  end
end

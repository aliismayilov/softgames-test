require 'rails_helper'

describe SessionsController do
  render_views

  describe 'GET create' do
    context 'with omniauth info' do
      let!(:auth) { OmniAuth.config.mock_auth[:google_oauth2] }

      before { set_env_with_omniauth_info! }

      it_should_behave_like 'action that saves return path' do
        before do
          get :create, provider: 'google_oauth2'
        end
      end

      context 'with new user' do
        context 'GET create' do
          before { get :create, provider: 'google_oauth2' }

          it { is_expected.to redirect_to picasa_path }

          it 'sets user_id on session' do
            expect(session[:user_id]).to eql(User.find_by(uid: auth['uid']).id)
          end
        end
      end

      context 'with existing user' do
        let!(:user) { create(:user, provider: 'google_oauth2', uid: auth.uid) }

        context 'GET create' do
          before { get :create, provider: 'google_oauth2' }

          it { is_expected.to redirect_to picasa_path }

          it 'sets user id in session' do
            expect(session[:user_id]).to eql(user.id)
          end
        end
      end
    end
  end

  describe 'GET failure' do
    it_should_behave_like 'action that saves return path' do
      before { get :failure }
    end

    it 'sets flash message' do
      get :failure
      expect(flash[:alert]).to eql 'You did not succeed. Please try again.'
    end

    describe 'redirect' do
      context 'no return_path' do
        before do
          session[:return_path] = nil
          get :failure
        end

        it { is_expected.to redirect_to root_path }
      end
    end
  end

  describe 'GET destroy' do
    it_should_behave_like 'action that saves return path' do
      before do
        get :destroy
      end
    end

    it 'should nuliffy user_id on sessions' do
      session[:user_id] = '1'

      get :destroy

      expect(session[:user_id]).to be_nil
    end

    it 'should redirect to root_path' do
      get :destroy
      is_expected.to redirect_to root_path
    end
  end
end

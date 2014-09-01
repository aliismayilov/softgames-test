require 'rails_helper'

describe ApplicationController do
  let(:user) { create(:user) }

  describe '#current_user' do
    context 'user signed in' do
      before do
        session[:user_id] = user.id
      end

      it 'returns the user' do
        expect(controller.send(:current_user)).to eql user
      end
    end

    context 'user signed in with invalid id' do
      before do
        session[:user_id] = 666
      end

      it 'deletes user_id from session' do
        expect {
          controller.send(:current_user)
        }.to change { session[:user_id] }.from(666).to(nil)
      end

      it 'returns nil' do
        expect(controller.send(:current_user)).to be_nil
      end
    end

    context 'user is not signed in' do
      it 'returns nil' do
        expect(controller.send(:current_user)).to be_nil
      end
    end
  end

  describe '#authenticate!' do
    context 'user is signed in' do
      before do
        session[:user_id] = user.id
      end

      it 'ignores redirection and proceeds' do
        expect(controller).to_not receive(:redirect_to)
        controller.send :authenticate!
      end
    end

    context 'user is not signed in' do
      it 'redirects to login' do
        redirect = double('redirect')
        request.define_singleton_method :fullpath do
          '/potato'
        end

        expect(controller)
          .to receive(:redirect_to)
          .with(login_url(provider: 'google_oauth2', origin: '/potato'),
                notice: 'You need to sign in...')
          .and_return(redirect)

        expect(controller.send(:authenticate!)).to eql redirect
      end
    end

    context 'omniauth token is expired' do
      before do
        session[:user_id] = user.id
        user.update(token_expires_at: 1.hour.ago)
      end

      it 'redirects to login' do
        redirect = double('redirect')
        request.define_singleton_method(:fullpath) { '/potato' }

        expect(controller)
          .to receive(:redirect_to)
          .with(login_url(provider: 'google_oauth2', origin: '/potato'),
                notice: 'You need to sign in...')
          .and_return(redirect)

        expect(controller.send(:authenticate!)).to eql redirect
      end
    end
  end
end

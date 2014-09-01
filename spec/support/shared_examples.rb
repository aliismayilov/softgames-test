shared_examples_for 'action that requires authentication' do
  context 'not logged in' do
    before { action }
    it { expect(flash[:notice]).to eql("You need to sign in...") }
    it {
      origin = request.post? ? root_url : request.fullpath
      is_expected.to redirect_to(login_url(provider: 'google_oauth2', origin: origin))
    }
  end
end

shared_examples_for 'action that saves return path' do
  before { session[:return_path] = '/potato' }
  it { expect(session[:return_path]).to eql('/potato') }
end

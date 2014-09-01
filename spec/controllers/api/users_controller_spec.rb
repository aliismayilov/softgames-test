require 'rails_helper'

RSpec.describe Api::UsersController, :type => :controller do
  before { request.accept = Mime::JSON }

  describe "GET show" do
    let(:action) { get :show }

    it_behaves_like 'action that requires authentication' do
      before { action }
    end

    context 'logged in' do
      before { login! }

      it "returns only some fields" do
        action
        expect(JSON.parse(response.body).keys).to match_array %w(id app_token email image name provider token_expires_at uid created_at updated_at)
      end
    end
  end
end

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

      it "returns http success" do
        action
        expect(response.body).to eql current_user.to_json
      end
    end
  end
end

require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET picasa" do
    let(:action) { get :picasa }

    it_behaves_like 'action that requires authentication' do
      before { action }
    end

    context 'logged in' do
      before { login! }

      it "returns http success" do
        action
        expect(response).to be_success
      end
    end
  end

end

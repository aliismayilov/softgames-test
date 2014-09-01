require 'rails_helper'

RSpec.describe Api::CommentsController, :type => :controller do
  before { request.accept = Mime::JSON }

  describe "POST create" do
    let(:action) { post :create, params }

    it_behaves_like 'action that requires authentication' do
      let(:params) { { } }
      before { action }
    end

    context 'logged in' do
      let(:params) do
        {
          comment: {
            content: 'Hello',
            albumId: '123123123',
            photoId: '141231231'
          }
        }
      end
      before do
        login!
        allow(RestClient).to receive(:post) { double('response', code: 201) }
      end

      it 'sends a POST request RestClient' do
        expect(RestClient).to receive(:post)
        action
      end

      it 'responds created with no content' do
        action
        expect(response.code).to eq '201'
        expect(response.body).to be_blank
      end
    end
  end
end

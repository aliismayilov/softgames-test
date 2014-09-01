require 'rails_helper'

RSpec.describe Api::CommentsController, :type => :controller do
  before { request.accept = Mime::JSON }

  describe "POST create" do
    let(:action) { post :create, params }

    it_behaves_like 'action that requires authentication' do
      let(:params) { { } }
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
        allow_any_instance_of(Api::CommentsController).to receive(:current_user).and_return(current_user)
        allow(RestClient).to receive(:post) { double('response', code: 201, body: '<xml></xml>') }
      end

      it 'sends a POST request RestClient' do
        expect(RestClient).to receive(:post)
        action
      end

      it 'responds created with json content' do
        action
        expect(response.code).to eq '201'
        expect(response.body).to eql '{"xml":null}'
      end
    end
  end

  describe "GET index" do
    let(:action) { get :index }

    it_behaves_like 'action that requires authentication'

    context 'logged in' do
      before do
        login!
        allow(RestClient).to receive(:get) { double('response', code: 200, body: { json: true }) }
      end

      it 'sends a GET request with RestClient' do
        expect(RestClient).to receive(:get)
        action
      end

      it 'responds with json content' do
        action
        expect(response.code).to eq '200'
        expect(response.body).to eql '{"json":true}'
      end
    end
  end
end

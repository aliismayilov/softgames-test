require 'rails_helper'

RSpec.describe Api::AlbumsController, :type => :controller do
  before { request.accept = Mime::JSON }

  describe "GET index" do
    let(:action) { get :index }

    it_behaves_like 'action that requires authentication' do
      let(:params) { { } }
      before { action }
    end

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

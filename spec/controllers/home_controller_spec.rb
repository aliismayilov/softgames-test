require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET picasa" do
    it "returns http success" do
      get :picasa
      expect(response).to be_success
    end
  end

end

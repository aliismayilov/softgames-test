class UsersController < ApplicationController
  respond_to :json
  before_filter :authenticate!

  def show
    respond_with current_user
  end
end

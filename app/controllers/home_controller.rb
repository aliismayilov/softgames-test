class HomeController < ApplicationController
  before_filter :authenticate!, except: :index

  def index
  end

  def picasa
  end
end

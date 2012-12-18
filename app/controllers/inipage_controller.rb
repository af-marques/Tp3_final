class InipageController < ApplicationController

  def index
    @categories = Category.all
  end


end

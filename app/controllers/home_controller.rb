class HomeController < ApplicationController
  def main
    @categories = Category.all
  end
end

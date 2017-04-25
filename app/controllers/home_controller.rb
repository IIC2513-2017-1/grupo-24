class HomeController < ApplicationController
  def main
    @categories = Category.all
  end

  def search
    @by_title = Project.where('title ILIKE :search',
                                 search: "%#{params[:search]}%")
    @by_content = Project.where('content ILIKE :search',
                                 search: "%#{params[:search]}%")
    @by_category = Project.where('category = :search',
                                 search: "%#{params[:search]}%")
  end
end

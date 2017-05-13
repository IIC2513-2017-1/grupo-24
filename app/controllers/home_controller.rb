class HomeController < ApplicationController
  def main
    @projects = Project.all.order(id: :desc).limit(3)
  end

  def search
    @by_title = Project.where('title ILIKE :search AND publish = true',
                                 search: "%#{params[:search]}%")
    @by_content = Project.where('description ILIKE :search  AND publish = true',
                                 search: "%#{params[:search]}%")
    #@by_category = Project.where('category = :search',
    #                             search: "%#{params[:search]}%")
  end
end

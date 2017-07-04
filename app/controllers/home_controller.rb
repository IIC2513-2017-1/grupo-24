class HomeController < ApplicationController

  def main
    @projects = Project.where(publish: true).order(rating: :desc).limit(6)
  end

  def search
    @last_search = params[:search]
    @categories = Category.all
    @projects = Project.where("title ILIKE :search AND publish = true",
                              search: "%#{params[:search]}%")
  end

  def category_filter
    @projects = Project.where("title ILIKE :search AND publish = true",
                              search: "%#{params[:search]}%")
                       .select {|project| params[:filters].include?(project.category.name)}
    respond_to do |format|
      format.js { render layout: false }
      format.html {head :no_content }
    end
  end
end

class HomeController < ApplicationController
  def main
    @projects = Project.all.order(id: :desc).limit(3)
  end

  def search
    @last_search = params[:search]
    @categories = Category.all
    @projects = Project.where("title ILIKE :search AND publish = true",
                              search: "%#{params[:search]}%")
  end

  def category_filter
    puts '########################################3', 'AQUIII'
    @last_search = params[:search]
    @categories = Category.all
    @projects = Project.where("title ILIKE :search AND publish = true",
                              search: "%#{params[:search]}%")
                       .select {|project| params[:filters].include?(project.category.name)}
    puts @projects.size
    respond_to do |format|
      format.js
    end
  end
end

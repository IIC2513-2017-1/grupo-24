class HomeController < ApplicationController
  def main
    @projects = Project.all.order(id: :desc).limit(3)
  end

  def search
    @projects = []
    if params[:classification] == 'Categoria'
      @categories = Category.where('name ILIKE :search', search: params[:search])
      @categories.each do |category|
        category.projects.map { |project| @projects << project if project.publish }
      end
    else
      query = params[:classification] == 'Contenido' ? 'description' : 'title'
      @projects = Project.where("#{query} ILIKE :search AND publish = true",
                                search: "%#{params[:search]}%")
    end
  end
end

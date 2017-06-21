module Api::V1
  class ProjectsController < ApiController

    def index
      @projects = Project.all
    end

    def create
      @project = Project.new(project_params)
      unless @project.save
        render json: { errors: @project.errors }, status: :unprocessable_entity
      end
    end

    def show
      @tweet = Project.find(params[:id])
    end

    private

    def project_params
      params.require(:project)
      .permit(:goal, :title, :description, :user_id, :category_id,
      :image, :publish, :end_date)
    end

  end
end

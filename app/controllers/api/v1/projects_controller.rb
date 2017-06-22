module Api::V1
  class ProjectsController < ApiController
    before_action :authenticate

    def index
      @projects = Project.all
    end

    def create
      @project =  @current_user.projects.build(project_params)
      unless @project.save
        render json: { errors: @project.errors }, status: :unprocessable_entity
      end
    end

    def show
      @project = Project.find(params[:id])
    end

    def edit
      @project = Project.find(params[:id])
      @project.update(project_params)
    end

    private

    def project_params
      params.require(:project)
      .permit(:goal, :title, :description, :category_id,
      :image, :publish, :end_date)
    end

  end
end

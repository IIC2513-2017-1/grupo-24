class ProjectsController < ApplicationController
  include Secured

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: %i[new create edit update destroy]
  before_action :is_mine?, only: [:edit, :update, :destroy]
  before_action :available_categories, only: [:edit, :new, :update, :create]
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(publish: true).order(end_date: :desc, rating: :desc)
                       .paginate(page: params[:page], per_page: 9)
    @mines = false
    if request.original_url.to_s.include?('users')
      @mines = current_user ? current_user.id.to_s == params[:user_id] : false
      if @mines
        @projects = Project.where(user_id: params[:user_id])
                           .paginate(page: params[:page], per_page: 6)
      else
        @projects = Project.where(user_id: params[:user_id], publish: true)
                           .paginate(page: params[:page], per_page: 6)
      end
    end
  end

  def get_all
    if params[:all]
      @projects = Project.where(publish: true).order(end_date: :desc, rating: :desc)
    else
      @projects = Project.where('publish = true AND end_date >= :today',
                                today: Date.today)
                         .order(end_date: :desc, rating: :desc)
    end
  end
  # GET /projects/1
  # GET /projects/1.json
  def show
    unless @project.publish || current_user == @project.user
      flash[:warning] = 'Proyecto no disponible'
      redirect_to root_path
      @tweets = @project.tweets
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    unless @project.user == current_user
      flash[:error] = 'Acceso restringido'
      redirect_to :back
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project,
                      notice: 'Proyecto creado exitosamente.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    url = @project.user == current_user ? projects_path : user_projects_path(current_user)
    @project.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project)
          .permit(:goal, :title, :description, :user_id, :category_id,
                  :publish, :end_date, :video_url, :crop_x, :crop_y, :crop_h,
                  :crop_w, :image, :hashtag)
          .merge(user_id: current_user.id, achieve: false)

  end

  def is_mine?
    if @project.user != current_user
      redirect_to :back, alert: 'No puedes editar un proyecto ajeno'
    end
  end

  def available_categories
    @categories = Category.all + [Category.new(name: 'Sin categoría')]
  end
end

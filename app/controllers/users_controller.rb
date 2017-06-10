class UsersController < ApplicationController
  include Secured

  before_action :logged_in?, except: [:new, :create]
  before_action :is_admin?, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user != @user
      flash[:error] = 'No puedes editar un perfil ajeno'
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.admin = false
    respond_to do |format|
      if @user.save
        UserMailer.new_user_email(@user).deliver_later
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'Usuario creado' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if current_user != @user
      flash[:error] = 'No puedes editar un perfil ajeno'
      redirect_to root_path
    end
    respond_to do |format|
      if @user.authenticate(params[:user][:password]) && @user.update(user_params)
        format.html { redirect_to @user, notice: 'Usuario actualizado correctamente' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'El usuario fue eliminado permanentemente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :last_name,
                                   :username, :avatar)
    end
end

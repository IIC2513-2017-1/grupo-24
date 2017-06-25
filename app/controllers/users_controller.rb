class UsersController < ApplicationController
  include Secured

  before_action :logged_in?, except: [:new, :create]
  before_action :is_admin?, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_password, :edit_password]
  before_action :check_current, only: [:edit, :update, :change_password, :edit_password]
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
  def edit; end

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
    respond_to do |format|
      if @user.update(user_edit_params)
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

  def create_token
    @user = User.find_by(id: params[:user_id])
    @user.generate_token_and_save
    respond_to do |format|
      format.js { render layout: false }
      format.html {head :no_content }
    end
  end

  def edit_password
    respond_to do |format|
      if @user.authenticate(params[:user][:old_password])
        if @user.update(params.require(:user).permit(:password, :password_confirmation))
          format.html { redirect_to @user, notice: 'Contraseña cambiada' }
          format.json { render :show, status: :ok, location: @user }
        else
          flash.now[:error] = 'Las contraseñas no coinciden'
          format.html { render :change_password }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        flash.now[:error] = 'Contraseña errónea'
        format.html { render :change_password, error: 'Contraseña errónea' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_password; end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :last_name,
                                   :username, :password_confirmation, :crop_x,
                                   :crop_y, :crop_w, :crop_h, :avatar)
    end

    def user_edit_params
      params.require(:user).permit(:email, :name, :last_name, :username, :crop_x,
                                   :crop_y, :crop_w, :crop_h, :avatar)
    end

    def check_current
      if current_user != @user
        flash[:error] = 'No puedes editar un perfil ajeno'
        redirect_to root_path
      end
    end
end

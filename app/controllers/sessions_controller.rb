class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Inicio de sesión exitoso'
    else
      flash[:error] = 'Usuario o contraseña errónea'
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    flash[:info] = 'Su sesión ha concluido'
    redirect_to root_path
  end
end

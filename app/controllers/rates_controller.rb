class RatesController < ApplicationController
  include Secured

  before_action :logged_in?, only: %i[create destroy]

  def create
    @rate = Rate.find_by(user_id: current_user.id, project_id: params[:rate][:project_id])
    if @rate
      puts 'LO ENCOTNRE', '#################################'
      respond_to do |format|
        if @rate.update(rate_params)
          format.html { redirect_to @rate.project,
                        notice: 'Evaluación actualizada' }
        else
          format.html { redirect_to @rate.project,
                        error: 'No se pudo actualizar tu evaliacion' }
        end
      end
    else
      puts "NO ENCONTRADO #{current_user.id} y #{params[:rate][:project_id]}"
      @rate = Rate.new(rate_params)
      respond_to do |format|
        if @rate.save
          format.html { redirect_to project_path(@rate.project),
                        notice: 'Evaluación registrada' }
        else
          format.html { redirect_to Project.find_by(id: params[:rate][:project_id]),
                        error: 'Debes autentificarte antes de realizar evaluacion' }
        end
      end
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:project_id, :grade)
                             .merge(user_id: current_user.id)
  end
end

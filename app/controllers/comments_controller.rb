class CommentsController < ApplicationController
  include Secured

  before_action :logged_in?, only: %i[create]

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        @project = @comment.project
        format.js { render layout: false }
        format.html {head :no_content }
      else
        flash[:error] = 'Tu comentario debe poseer contenido' unless @comment.content.present?
        flash[:error] = 'Debes autentificarte antes de realizar una donacion' unless @comment.user_id.present?
        format.html {redirect_to :back}
      end
    end
  end

  def add_new
    @project = Project.find_by(id: params[:id])
    respond_to do |format|
      format.js { render layout: false }
      format.html {head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:project_id, :content)
                            .merge(user_id: current_user.id)
  end
end

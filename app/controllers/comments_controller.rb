class CommentsController < ApplicationController
  include Secured

  before_action :logged_in?, only: %i[create]

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if current_user && @comment.save
        format.html { redirect_to project_path(@comment.project) }
      else
        flash.now[:error] = 'Debes autentificarte antes de realizar una donacion'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:project_id, :content)
                            .merge(user_id: current_user.id)
  end
end
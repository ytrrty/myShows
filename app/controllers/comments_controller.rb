class CommentsController < ApplicationController
  before_action :get_parent

  def create
    @comment = @parent.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back fallback_location: root_path, flash: { success: 'Успішно' }
    else
      redirect_back fallback_location: root_path, flash: { error: 'Помилка' }
    end
  end

  protected

  def get_parent
    klass = comment_params[:commentable_type].constantize
    @parent = klass.find(comment_params[:commentable_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end

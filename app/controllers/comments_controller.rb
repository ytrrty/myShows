class CommentsController < ApplicationController
  before_filter :get_parent

  def new
    @comment = @parent.comments.build
  end

  def create
    @comment = @parent.comments.build(comment_params)
    if @comment.save
      redirect_to show_path(@comment.show), :notice => 'Thank you for your comment!'
    else
      render :new
    end
  end

  protected

  def get_parent
    @parent = Show.find(params[:show_id]) if params[:show_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]
    redirect_to root_path unless defined?(@parent)
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :user_id)
  end

end

class CommentsController < ApplicationController
  before_filter :require_login

  def require_login
    unless logged_in?
      flash.notice = "You must login first."
      redirect_to new_author_session_path
      return false
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    @comment.save
    redirect_to article_path(@comment.article)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end

class CommentsController < ApplicationController
  
  def show
  	@comment = Comment.new
    @weigh_in = WeighIn.find(params[:id])
  	@user = @weigh_in.user
  end
  
  def new
  end

  def create
    # sets the author to be the current user when written
  	@user = current_user
  	@user_id = @user.id
  	@weigh_in = WeighIn.find(params[:weigh_in_id])
  	@comment = @weigh_in.comments.create(comment_params)
  	@comment.user_id = @user_id
  	  if @comment.save
  	    redirect_to :back
  	  else
  	    render 'new'
  	  end
  end

  def destroy
    # @comment = User.find(params[:user_id]).weigh_ins.find(params[:weigh_in_id]).comment.find(:id)
     @comment = Comment.find(params[:id])
     @comment.destroy
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :weigh_in_id, :id)
  end
end


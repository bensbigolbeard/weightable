class CommentsController < ApplicationController
  
  def show
  	@comment = Comment.new
  	@user = current_user
  	@weigh_in = WeighIn.find(params[:id])
  end
  
  def new
  end

  def create
  	@user = current_user
  	@weigh_in = WeighIn.find(params[:weigh_in_id])
  	@comment = @weigh_in.comments.create(comment_params)
  	  if @comment.save
  	    redirect_to :back
  	  else
  	    render 'new'
  	  end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :weigh_in_id)
  end
end


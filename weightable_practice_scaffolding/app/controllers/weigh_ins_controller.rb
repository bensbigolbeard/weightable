class WeighInsController < ApplicationController

	def show
	  @user = current_user
	  @weigh_in = WeighIn.find(params[:id])
	  @weigh_ins = @user.weigh_ins
	  @comment = Comment.new
	  @wi_yeehaw = WiYeehaw.new
	  @wi_yeehaws = WiYeehaw.find_all_by_weigh_in_id(params[:id]).count
	end

	def index
		@weigh_ins = WeighIn.all include :user
		@weigh_in = WeighIn.new
	  # @user = User.find(params[:user_id]) if params[:user_id]
	  # @weigh_ins = @user ? @user.weigh_ins.all : WeighIn.all
	end

	def new
	  @weigh_in = WeighIn.new
	end

	def create
		@user= User.find(params[:id])
	  @weigh_in = @user.weigh_ins.create(weigh_in_params)
	  @weigh_in.user_id = current_user.id
	  if @weigh_in.save
	    redirect_to current_user
	  else
	    render 'new'
	  end
	end

	def edit
		@user = User.find(params[:user_id])
	  @weigh_in = WeighIn.find(params[:id])
	end

	def update
	  @weigh_in = WeighIn.find(params[:id])
	  @weigh_in.update(weigh_in_params)
	  if @weigh_in.update(weigh_in_params)
	  	flash[:notice] = "You have updated your weigh-in for today!"
	  	redirect_to user_path(params[:user_id])
	  else 
	  	render 'new'
	  end
	end

	# def destroy
	#   @video = Video.find(params[:id])
	#   @video.destroy
	#   redirect_to root_path
	# end

	private

	def weigh_in_params
	  params.require(:weigh_in).permit(:weight, :pic_url, :user_id, :status, :id, :created_at)
	end
end

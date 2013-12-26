class WeighInsController < ApplicationController

	def show
	  @weigh_in = WeighIn.find(params[:id])
	  @weigh_ins = @user.weigh_ins
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
	  @weigh_in = WeighIn.new(weigh_in_params)
	  @weigh_in.user_id = current_user.id
	  if @weigh_in.save
	    redirect_to current_user
	  else
	    render 'new'
	  end
	end

	def edit
	  @weigh_in = WeighIn.find(params[:id])
	end

	def update
	  @weigh_in = WeighIn.find(params[:id])
	  @weigh_in.update(weighin_params)
	  redirect_to root_path
	end

	# def destroy
	#   @video = Video.find(params[:id])
	#   @video.destroy
	#   redirect_to root_path
	# end

	private

	def weigh_in_params
	  params.require(:weigh_in).permit(:weight, :pic_url, :user_id, :status)
	end
end

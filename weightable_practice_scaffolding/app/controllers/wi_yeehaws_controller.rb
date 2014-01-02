class WiYeehawsController < ApplicationController

  def create
    @weigh_in = WeighIn.find(params[:weigh_in_id])
    @user = current_user
    if WiYeehaw.find_by_weigh_in_id(params[:weigh_in_id]) && WiYeehaw.find_by_user_id(params[:user_id])
      redirect_to :back
      flash[:notice]="You have already given this Weigh-In a Yeehaw! Why don't you go Yeehaw some more Weigh-Ins!"
    else
      @new_wi_yeehaw = @weigh_in.wi_yeehaws.create(yeehaw_params)
        if @new_wi_yeehaw.save
          redirect_to :back
        else
          redirect_to :back
        end
    end
  end

  def destroy
  end

  private
  def yeehaw_params
    params.permit(:user_id, :weigh_in_id, :id)
  end
end

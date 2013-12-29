class FriendshipsController < ApplicationController

	def create
    if current_user.friends.include?(User.find(params[:friend_id]))
      flash[:notice] = "You are already friends with this user"
    else
  		@friendship = current_user.friendships.create(friend_id: params[:friend_id])
      @new_user = User.find_by_id(params[:friend_id])
      @inverse_friendship = @new_user.friendships.create(friend_id: current_user.id)
      redirect_to root_path
    end
	end

  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:id])
    @friendship.destroy
    flash[:notice] = "Your friendship with #{User.find(params[:id]).name} has been removed."
    redirect_to current_user
  end
end

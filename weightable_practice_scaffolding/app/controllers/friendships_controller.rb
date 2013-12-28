class FriendshipsController < ApplicationController

	def create
		@friendship = current_user.friendships.create(friend_id: params[:friend_id])
    @new_user = User.find_by_id(params[:friend_id])
    @inverse_friendship = @new_user.friendships.create(friend_id: current_user.id)

    redirect_to root_path
	end
end

class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :get_user_list, :check_feed_notification


def get_user_list
  @autocomplete_items = []
  @users = User.all
  @users.each do |user|
    @autocomplete_items << 
      {
        id:     user.name, 
        value:  user.name,
        label: user.name
      }
  end 
end

def check_feed_notification
  @user = current_user
    if @user
    @recent_weigh_ins = []
    @user.friends.each do |friend|
      friend.weigh_ins.each do |weigh|
        if weigh.created_at > @user.last_sign_in_at
          @recent_weigh_ins << weigh
        end
      end
    end
    @notifications = @recent_weigh_ins.count
  end
end


protected

def configure_permitted_parameters
  [:name, :profile_pic].each do |field|
    devise_parameter_sanitizer.for(:sign_up) << field
    devise_parameter_sanitizer.for(:account_update) << field
  end
end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
end

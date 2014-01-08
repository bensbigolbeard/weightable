module ApplicationHelper

  def current_user_content(&block)
    capture(&block) if @user == current_user
  end

  def user_content(&block)
    capture(&block) if current_user
  end

  def visitor_content(&block)
    capture(&block) unless current_user
  end
end

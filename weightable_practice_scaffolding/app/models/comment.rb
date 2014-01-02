class Comment < ActiveRecord::Base
  belongs_to :weigh_in
  belongs_to :user


  def sorted_comments
    weight.comments.sort_by &:created_at
  end
end

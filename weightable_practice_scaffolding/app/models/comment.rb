class Comment < ActiveRecord::Base
  belongs_to :weigh_in
  belongs_to :user

end

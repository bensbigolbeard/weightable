class WeighIn < ActiveRecord::Base
	default_scope order: 'created_at DESC'
	belongs_to :user
	validates :weight, presence: true
	has_many :comments
  has_many :wi_yeehaws
  has_many :users, :through => :wi_yeehaws
end

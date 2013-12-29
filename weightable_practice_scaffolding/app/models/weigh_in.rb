class WeighIn < ActiveRecord::Base
	default_scope order: 'created_at DESC'
	belongs_to :user
	validates :weight, presence: true
	has_many :comments
end

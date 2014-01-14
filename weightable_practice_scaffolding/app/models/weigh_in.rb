class WeighIn < ActiveRecord::Base
	default_scope order: 'created_at DESC'
	belongs_to :user
	validates :weight, presence: true
	has_many :comments
  has_many :wi_yeehaws

  #Carrierwave
  mount_uploader :pic_url, ImageUploader

  # scope :recent, :limit => 25, :order => 'created_at DESC'

end

class WeighIn < ActiveRecord::Base
	# default_scope order: 'created_at DESC'
	belongs_to :user
	validates :weight, presence: true

  # scope :recent, :limit => 100, :order => 'created_at DESC'

  def self.latestpost
    order("created_at DESC").limit(1).last
  end

  def self.secondlatestpost
    order("created_at DESC").offset(1).limit(1).last
  end
end


class User < ActiveRecord::Base
	has_many :weigh_ins
	has_many :comments
	has_many :wi_yeehaws
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
	has_many :friendships
	has_many :friends, through: :friendships

	#Nested Fields
	accepts_nested_attributes_for :weigh_ins

	#Fuzzily
	fuzzily_searchable :name

	#Carrierwave
	mount_uploader :profile_pic, ImageUploader

	# allow email blank for first create
	validates_format_of :email, :with => Devise.email_regexp, :allow_blank => true, :if => :email_changed?

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	    user = User.where(:provider => auth.provider, :uid => auth.uid).first
		    if user
		      return user
		    else
		      registered_user = User.where(:email => auth.info.email).first
		      if registered_user
		        return registered_user
		      else
		        user = User.create(name:auth.extra.raw_info.name,
		                            provider:auth.provider,
		                            uid:auth.uid,
		                            profile_pic:auth.info.image,
		                            email:auth.info.email,
		                            password:Devise.friendly_token[0,20],
		                          )
		    end    
	  	end
	end
	
	def self.search(search)
    User.find_by_fuzzy_name(search, :limit=> 10)
  end

  def sorted_comments
    weight.comments.sort_by &:created_at
  end
end

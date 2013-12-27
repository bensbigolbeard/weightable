class User < ActiveRecord::Base
	has_many :weigh_ins
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
	has_many :friendships
	has_many :friends, through: :friendships

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
		                            pic_url:auth.info.image,
		                            email:auth.info.email,
		                            password:Devise.friendly_token[0,20],
		                          )
		    end    
	  	end
	end
	

end

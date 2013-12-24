class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
	has_many :friendships
	has_many :friends, through: :friendships


	def show
	  @user = User.find(params[:uid])
	end

	def show_all
	  @user = User.all
	end

	# def new
	#   @user = User.new
	# end

	# def create
	#   user = User.new(user_params)
	#   user.save
	#   redirect_to root_path
	# end

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  unless user
	    user = User.create(name:auth.extra.raw_info.name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
	                         password:Devise.friendly_token[0,20]
	                         )
	  end
	  user
	end

	

	private
	def user_params
	  params.require(:user).permit(:name, :provider, :uid)
	end

end

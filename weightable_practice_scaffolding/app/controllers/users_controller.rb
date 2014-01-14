class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    if current_user
      @user = current_user
    else 
      @user= User.new(name:"Guest")
    end

    @weigh_in = @user.weigh_ins.new
    @weigh_ins = @user.weigh_ins
    
  end

  def feed
    @users = User.all
    if current_user
      @user = current_user
    else 
      @user= User.new(name:"Guest")
    end

    @weigh_in = @user.weigh_ins.new
    @weigh_ins = @user.weigh_ins
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @users = User.all
    @weigh_in = WeighIn.new
    @comment = Comment.new
    @weigh_in_update = @user.weigh_ins.first
    @weights = []
    @dates = []
    @goal = []
    @day_initials = []

    @user.weigh_ins.last(10).each do |weight|
      @weights.unshift(weight.weight) 
      @goal.unshift(@user.goal) 
      @dates.unshift((weight.created_at).strftime("%a"))
      @day_initials.unshift((weight.created_at).strftime("%a")[0])
    end
    
    #sets array for array of differences
    @array_of_differences = @weights.each_cons(2).map { |a,b| b-a }
  
    if @array_of_differences.size > 0
      @avg_difference = ((@array_of_differences.reduce(:+) / @array_of_differences.length))
      @pounds_to_go = (@user.goal - @user.weigh_ins.last.weight)
      @days_remaining_to_goal = ((@user.goal_date - DateTime.now).to_i)
      @finish_date = ((DateTime.now+(@pounds_to_go/@avg_difference).to_i)).strftime("%b %-d")
      @finish_estimate = ((@finish_date.to_datetime - DateTime.now).to_i)
      if (@days_remaining_to_goal < (@pounds_to_go / @avg_difference))
        @on_track_icon = "X"
        @goal_projection_status = "OFF&nbsp;TRACK".html_safe;
      else  
        @on_track_icon = ":)"
        @goal_projection_status = "ON&nbsp;TRACK".html_safe
      end
    else
      @goal_projection_status = "N/A"
      @finish_date = "N/A"
      @finish_estimate = "N/A"
    end
  end

  def search
    @users = User.all
    @results = @users.search(params[:search])
  end

  # GET /users/new
  def new
    @user = User.new

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
        redirect_to :back
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def friends
    @user = current_user
  end

  def all_users
    @users = User.all
    @user = current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

  def user_params
    params.require(:user).permit(:name, :provider, :uid, :profile_pic, :goal, :goal_date,  :height_in_feet, :height_in_inches, weigh_ins_attributes: [:id, :weight])
  end

 
end

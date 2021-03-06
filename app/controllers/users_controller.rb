class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  after_filter only: [:index] { paginate(:users) }
  after_filter only: [:following] { paginate(:users) }
  after_filter only: [:followers] { paginate(:users) }

  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html { render :html => "show" }
        format.json { render :json => @user }
      end
  end
  
  def new
    @user = User.new
  end
  
    def edit
  end
  
  def create
    @user = User.new(params[:user]) 
    if @user.save
      UserMailer.welcome_email(@user).deliver
      10.times { @user.high_scores.create!(score: 0)}
      sign_in @user
      flash.now[:success] = "Welcome to the Tetrispals!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def index
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 10 ).order('name ASC')

    respond_to do |format|
      format.html { render :html => "index" }
      format.json { render :json => @users }
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], per_page: 10 )

    respond_to do |format|
      format.html { render "show_follow" }
      format.json { render :json => @users }
    end
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10 )
    
    respond_to do |format|
      format.html { render "show_follow" }
      format.json { render :json => @users }
    end
  end
  
  private

  def signed_in_user
    if not signed_in? and params[:format] != "json"
      redirect_to signin_url, notice: "Please sign in" 
    elsif not signed_in? and params[:format] == "json"
      render :json => { :message => "Not logged in" }, :status => 401
    end
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  
  
end

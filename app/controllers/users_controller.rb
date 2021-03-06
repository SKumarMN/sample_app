class UsersController < ApplicationController

  before_filter :signed_in_user , only: [:index,:edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  def index
    @users= User.paginate(page: params[:page])
    
  end

  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def destroy
     user = User.find(params[:id]).destroy
     flash[:success] = "#{user.name} is deleted "
     redirect_to users_url
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"

  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user=  User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated succesfully"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
    
  end


  private

  

   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end

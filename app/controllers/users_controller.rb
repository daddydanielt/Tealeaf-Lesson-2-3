class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]


  def show
    #binding.pry
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successful Registration !"
      redirect_to root_path
    else      
      render :new
    end
  end

  def edit
    
  end

  def update
     if @user.update(user_params)
      flash[:notice] = "Your profile has been updated."  
      redirect_to user_path
    else      
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    #@user = User.find(params[:id]) 
    @user = User.where(username: params[:username]).first    
    #binding.pry
  end

  def require_same_user    
    #if current_user.id != params[:id]
    if current_user != @user
      flash[:errors] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end
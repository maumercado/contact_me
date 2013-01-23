class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
  end

  def create
    if @user.save
      flash[:success] = "User created!"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def index
    @users = User.order(:name).search(params[:search]).page(params[:page]).per(15)
  end

  def show
  end

  def destroy
    flash[:success] = "User " + @user.name + " Deleted"
    redirect_to users_path
  end
end

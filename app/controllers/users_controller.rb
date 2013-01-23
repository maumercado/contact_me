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

  def edit
  end

  def update
    @user.group_ids = params[:group_ids]
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      flash[:success] = "Group updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User " + @user.name + " Deleted"
    redirect_to users_path
  end
end

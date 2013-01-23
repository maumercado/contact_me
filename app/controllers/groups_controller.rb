class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @groups = Group.order(:name).search(params[:search]).page(params[:page]).per(15)
  end

  def show
  end

  def new
  end

  def create
    @group.user_ids = params[:user_ids]
    if @group.save
      flash[:success] = "New group created"
      redirect_to @group
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @group.user_ids = params[:user_ids]
    if @group.update_attributes(params[:group])
      flash[:success] = "Group updated!"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:success] = "Group " + @group.name + " Deleted"
    redirect_to groups_path
  end

end

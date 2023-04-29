class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_corrent_user
    @group = Group.find(params[:id])
    unless @group.user_id == current_user.id
      redirect_to groups_path
    end
  end
end
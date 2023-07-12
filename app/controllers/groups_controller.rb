class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.includes(:entities).where(user: current_user)
  end

  def new; end

  def create
    current_user.groups.create(group_params)
    redirect_to groups_path
  end

  private

  def group_params
    params.required(:group).permit(:name, :icon)
  end
end

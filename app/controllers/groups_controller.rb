class GroupsController < ApplicationController
    def index
      @groups = Group.includes(:entities).where(user: current_user)
    end

    def create
      current_user.groups.create(group_params)
      redirect_to root_path
    end

    private

    def group_params
      params.required(:group).permit(:name, :icon)
    end

  end
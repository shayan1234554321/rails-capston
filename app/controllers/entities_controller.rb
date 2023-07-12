class EntitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.includes(:entities).find_by_id(params[:group_id])
    @entities = @group.entities.order(created_at: :desc)
  end

  def new
    @group = Group.find_by_id(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @entity = @group.entities.new({ user: current_user, **entity_params })
    @entity.save

    redirect_to group_entities_path(@group)
  end

  private

  def entity_params
    params.required(:entity).permit(:name, :amount)
  end
end

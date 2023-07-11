class EntitiesController < ApplicationController
    def index
      @group = Group.includes(:entities).find(id: params[:group_id])
    end
  
    def create
      @group = Group.find(params[:group_id])
      @entity = @group.entities.new(entity_params)
      @entity.user = current_user
      @entity.save

      redirect_to group_entities_path(@group)
    end
  
    private
  
    def entity_params
      params.required(:entity).permit(:name, :amount)
    end
  end
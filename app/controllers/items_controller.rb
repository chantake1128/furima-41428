class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

    private

    def item_params
      params.require(:item).permit(:image, :name, :info, :category_id, :status_id, :cost_id, :prefecture_id, :day_id, :price)
    end
  
end


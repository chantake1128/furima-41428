class ItemsController < ApplicationController
  before_action :set_item, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update, :destroy]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  
  def edit
    if Order.where(item_id: @item.id).exists?
      redirect_to root_path
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

    private

    def set_item
      @item = Item.includes(:user).find(params[:id])
    end

    def item_params
      params.require(:item).permit(:image, :name, :info, :category_id, :status_id, :cost_id, :prefecture_id, :day_id, :price).merge(user_id: current_user.id)
    end

    def correct_user
      @item = Item.find(params[:id])
      unless @item.user == current_user
        redirect_to root_path
      end
    end
    
  
end


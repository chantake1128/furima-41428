class OrdersController < ApplicationController
  before_action :set_item, only:[:index, :create]

  def index
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    @form.user_id = current_user.id
    @form.item_id = @item.id
    if @form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def form_params
    params.require(:form).permit(
      :user_id, :item_id,
      #下はdeliveryテーブル
      :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number)
  end

end

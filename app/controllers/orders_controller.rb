class OrdersController < ApplicationController
  before_action :set_item, only:[:index, :create]

  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user != @item.user && Order.where(item_id: @item.id).exists?
      redirect_to root_path
    elsif current_user == @item.user
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY_TEST"]
      @form = Form.new
    end
  end
    

  def create
    @form = Form.new(form_params)
    @form.user_id = current_user.id
    @form.item_id = @item.id
    if @form.save
      pay_item
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY_TEST"]
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
      #下はクレジット決済のトークン
      .merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY_TEST"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

end

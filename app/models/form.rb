class Form
  include ActiveModel::Model
  include ActiveModel::Attributes
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :order_id
 # building_nameは必須ではないためvalidatesは設定していません
  validates :postal_code,           presence: true
  validates :prefecture_id,         numericality: { other_than: 1, message: "can't be blank"}
  validates :city,                  presence: true
  validates :street_address,        presence: true
  validates :phone_number,          presence: true

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Delivery.create!(
        postal_code:    postal_code,
        prefecture_id:  prefecture_id,
        city:           city,
        street_address: street_address,
        building_name:  building_name,
        phone_number:   phone_number,
        order_id:       order.id
      )
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Transaction failed: #{e.record.errors.full_messages.join(", ")}")
    false
  end
end
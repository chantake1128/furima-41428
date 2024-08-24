class Form
  include ActiveModel::Model
  include ActiveModel::Attributes
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :order_id, :token
 # building_nameは必須ではないためvalidatesは設定していません
  validates :postal_code,           presence: true
  validates :prefecture_id,         numericality: { other_than: 1, message: "can't be blank"}
  validates :city,                  presence: true
  validates :street_address,        presence: true
  validates :phone_number,          presence: true
  validates :user_id,               presence: true
  validates :item_id,               presence: true
  validates :token,                 presence: true
  validate  :check_postal_code_format
  validate  :validate_phone_number_format


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
        errors.add(:base, e.message)
        false
  end

    private
    def check_postal_code_format
      if postal_code.present? && postal_code !~ /\A\d{3}-\d{4}\z/
        errors.add(:postal_code, "is invalid. Include hyphen(-)")
      end
    end
  
    def validate_phone_number_format
      if phone_number.to_s.length < 10
        errors.add(:phone_number, "is too short. It should be 10 or 11 digits")
      elsif phone_number.to_s.length > 11
        errors.add(:phone_number, "is too long. It should be 10 or 11 digits")
      elsif phone_number.to_s !~ /\A[0-9]+\z/
        errors.add(:phone_number, "is invalid. Only numbers are allowed")
      end
    end

end


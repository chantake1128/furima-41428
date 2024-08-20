class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  has_one_attached :image

  belongs_to :user

# ActiveHashの関連付け
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  validates :name,               presence: true
  validates :info,               presence: true
  validates :category_id,        numericality: { other_than: 1, message: "can't be blank"}
  validates :status_id,          numericality: { other_than: 1, message: "can't be blank"}
  validates :cost_id,            numericality: { other_than: 1, message: "can't be blank"}
  validates :prefecture_id,      numericality: { other_than: 1, message: "can't be blank"}
  validates :day_id,             numericality: { other_than: 1, message: "can't be blank"}
  validates :price,              presence: true
end

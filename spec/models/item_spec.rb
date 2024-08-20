require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品登録' do
    context '商品を出品できる場合' do
      it "  image,name,info,category_id,status_id,cost_id,prefecture_id,day_id,price_idが存在すれば出品できる" do
      end
    context '商品を出品できない場合' do
      it "imageが空だと出品できない" do
      end
      it "nameが空だと出品できない" do
      end
      it "infoが空だと出品できない" do
      end
      it "category_idが1だと出品できない" do
      end
      it "status_idが1だと出品できない" do
      end
      it "cost_idが1だと出品できない" do
      end
      it "prefecture_idが1だと出品できない" do
      end
      it "day_idが1だと出品できない" do
      end
      it "priceが空だと出品できない" do
      end
      it "priceが299以下だと出品できない" do
      end
      it "priceが10000000以上だと出品できない" do
      end
      it "priceに小数点が入っていると出品できない" do
      end
      it "priceに文字列が入っていると出品できない" do
      end
      it "priceは全角数値だと出品できない" do
      end
    end
end

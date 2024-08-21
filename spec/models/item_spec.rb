require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品出品登録' do
    context '商品を出品できる場合' do
      it "  image,name,info,category_id,status_id,cost_id,prefecture_id,day_id,price_idが存在すれば出品できる" do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない場合' do
      it "imageが空だと出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空だと出品できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "infoが空だと出品できない" do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it "category_idが1だと出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "status_idが1だと出品できない" do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it "cost_idが1だと出品できない" do
        @item.cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end
      it "prefecture_idが1だと出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "day_idが1だと出品できない" do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank")
      end
      it "priceが空だと出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "priceが299以下だと出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "priceが10000000以上だと出品できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it "priceに小数点が入っていると出品できない" do
        @item.price = 1234.5
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be an integer")

      end
      it "priceに文字列が入っていると出品できない" do
        @item.price = 'てすと'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "priceは全角数値だと出品できない" do
        @item.price = '１２３４'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "ユーザー紐づいていないと無効である" do
        item = FactoryBot.build(:item, user: nil)
        item.valid?
        expect(item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Form, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @form = FactoryBot.build(:form, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品を購入できる場合' do
      it 'user_id,item_id,postal_code,prefecture_id,city,street_address,phone_numberがある場合購入できる' do
        expect(@form).to be_valid
      end
      it 'building_nameが空でも購入できる'do
        @form.building_name = ''
        expect(@form).to be_valid
      end
    end

    context '商品を購入できない場合' do
      it 'ユーザーと紐づいていないと購入できない' do
        @form.user_id = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("User can't be blank")
      end
      it '商品と紐づいていないと購入できない' do
        @form.item_id = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeが空だと購入できない' do
        @form.postal_code = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeはハイフンがないと購入できない' do
        @form.postal_code = '12345678'
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeはハイフン前後の数字の数が正しくないと購入できない' do
        @form.postal_code = '1234-567'
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeは英字を含むと購入できない' do
        @form.postal_code = '123-abcd'
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが1だと購入できない' do
        @form.prefecture_id = 1
        @form.valid?
        expect(@form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと購入できない' do
        @form.city = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("City can't be blank")
      end
      it 'street_addressが空だと購入できない' do
        @form.street_address = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Street address can't be blank")
      end
      it 'phone_numberが空だと購入できない' do
        @form.phone_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは9桁以下だと購入できない' do
        @form.phone_number = '123456789'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is too short. It should be 10 or 11 digits")
      end
      it 'phone_numberは12桁以上だと購入できない' do
        @form.phone_number = '123456789012'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is too long. It should be 10 or 11 digits")
      end
      it 'phone_numberは半角英字があると購入できない' do
        @form.phone_number = 'abc4567890'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is invalid. Only numbers are allowed")
      end
      it 'phone_numberは全角英字があると購入できない' do
        @form.phone_number = 'ＡＢＣ4567890'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is invalid. Only numbers are allowed")
      end
      it 'phone_numberはひらがながある購入できない' do
        @form.phone_number = 'あいう4567890'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is invalid. Only numbers are allowed")
      end
      it 'phone_numberはカタカナがあると購入できない' do
        @form.phone_number = 'アイウ4567890'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is invalid. Only numbers are allowed")
      end
      it 'phone_numberは漢字があると購入できない' do
        @form.phone_number = '亜伊宇4567890'
        @form.valid?
        expect(@form.errors.full_messages).to include( "Phone number is invalid. Only numbers are allowed")
      end
    end
  end

end

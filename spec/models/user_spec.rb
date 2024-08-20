require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail,passwordとpassword_confirmation,first_name,last_name,
          first_name_kana,last_name_kana,birth_dayが存在すれば登録できる"do
          expect(@user).to be_valid
     end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない"do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない"do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailが重複すると登録できない"do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it "emailに@がないと登録できない"do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "passwordが空では登録できない"do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下の場合登録できない"do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it "passwordとpassword_confirmationの値が一致しないと登録できない"do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameが空では登録できない"do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
      it "first_nameが空では登録できない"do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
        end
      it "last_name_kanaが空では登録できない"do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "first_name_kanaが空では登録できない"do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "birth_dayが空では登録できない"do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
        end

      it "first_nameが半角文字であれば登録できない"do
        @user.first_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it "first_nameが英数字であれば登録できない"do
        @user.first_name = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end

      it "last_nameが半角文字であれば登録できない"do
        @user.last_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it "last_nameが英数字であれば登録できない"do
        @user.last_name = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end

      it "first_name_kanaが半角文字であれば登録できない"do
        @user.first_name_kana = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it "first_name_kanaが英数字であれば登録できない"do
        @user.first_name_kana = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it "first_name_kanaがひらがなであれば登録できない"do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it "first_name_kanaが漢字であれば登録できない"do
        @user.first_name_kana = '試験'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end

      it "last_name_kanaが半角文字であれば登録できない"do
        @user.last_name_kana = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it "last_name_kanaが英数字であれば登録できない"do
        @user.last_name_kana = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it "Last_name_kanaがひらがなであれば登録できない"do
        @user.last_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it "last_name_kanaが漢字であれば登録できない"do
        @user.last_name_kana = '試験'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
    end
  end
end
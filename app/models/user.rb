class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    has_many :items
    has_many :orders
  
    validates :nickname,           presence: true
    validates :birth_day,          presence: true
    validates :last_name,          presence: true
    validates :first_name,         presence: true
    validates :last_name_kana,     presence: true
    validates :first_name_kana,    presence: true
  
    validate :validate_full_width_characters
    validate :validate_password_format, if: -> { password.present? }
  
    private
  
    def validate_full_width_characters
      if last_name.present? && last_name !~ /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
        errors.add(:last_name, "is invalid. Input full-width characters")
      end
  
      if first_name.present? && first_name !~ /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
        errors.add(:first_name, "is invalid. Input full-width characters")
      end
  
      if last_name_kana.present? && last_name_kana !~ /\A[ァ-ヶー]+\z/
        errors.add(:last_name_kana, "is invalid. Input full-width katakana characters")
      end
  
      if first_name_kana.present? && first_name_kana !~ /\A[ァ-ヶー]+\z/
        errors.add(:first_name_kana, "is invalid. Input full-width katakana characters")
      end
    end

    def validate_password_format
      unless password =~ /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
        errors.add(:password, 'must include both letters and numbers')
      end
    end
  end
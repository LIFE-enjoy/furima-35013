class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 with_options presence: true do
    validates :nickname
    validates :last_name, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角かな/カナ/漢字で入力してください"}
    validates :first_name, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角かな/カナ/漢字で入力してください"}
    validates :last_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: "は全角カナ入力してください"}
    validates :first_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: "は全角カナ入力してください"}
    validates :birth_date
    validates :password_confirmation
 end
    validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は半角英数字で入力してください"}, confirmation: true
end

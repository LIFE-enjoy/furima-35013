class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :ship_date
  belongs_to :shipping_cost
  belongs_to :status

  validates :image, presence: { message: 'を添付してください' } 

  with_options presence: true do
    validates :name
    validates :info
    validates :price_before_type_cast, numericality: { 
      greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'は¥300~¥9,999,999で入力してください', allow_blank: true
      }, format: {
        with: /\A[0-9]+\z/, message: 'は半角数字で入力してください', allow_blank: true 
       }
    with_options numericality: { other_than: 0, message: 'を選択してください' } do 
      validates :category_id
      validates :prefecture_id
      validates :ship_date_id
      validates :shipping_cost_id
      validates :status_id
    end
  end
end

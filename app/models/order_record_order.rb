class OrderRecordOrder

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: }
    validates :city
    validates :address
    validates :phone_number
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }

  def save
    order = Order.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number
    )
    order_record = OrderRecord.create(user_id: user_id, item_id: item_id)
  end
end
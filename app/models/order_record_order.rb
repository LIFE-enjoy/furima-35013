class OrderRecordOrder
  include ActiveModel::Model
  attr_accessor :receiver, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_record_id, :user_id, :item_id,
                :token

  with_options presence: true do
    validates :receiver
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'に-(ハイフン)をつけてください', allow_blank: true }
    validates :city
    validates :address
    validates :phone_number, length: { maximum: 11 }, format: {
      with: /\A[0-9]+\z/, message: 'は半角数字で入力してください', allow_blank: true
    }
    validates :user_id
    validates :item_id
    validates :token

    validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }
  end
  def save
    order_record = OrderRecord.create(user_id: user_id, item_id: item_id)
    Order.create(
      receiver: receiver, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_record_id: order_record.id
    )
  end
end

require 'rails_helper'

RSpec.describe OrderRecordOrder, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_record_order = FactoryBot.build(:order_record_order)
    @order_record_order.user_id = user.id
    @order_record_order.item_id = item.id
    sleep 0.1
  end
  describe '商品の購入' do
    context '商品の購入ができる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_record_order).to be_valid
      end
      it '建物名が抜けていても登録できる' do
        @order_record_order.building = ''
        expect(@order_record_order).to be_valid
      end
    end
    context '商品の購入ができない場合' do
      it 'クレジットカード情報が空では登録できない' do
        @order_record_order.token = nil
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
      it '宛名が空では登録できない' do
        @order_record_order.receiver = ''
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('宛名を入力してください')
      end
      it '郵便番号が空だと保存できない' do
        @order_record_order.postal_code = nil
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号にハイフンがないと保存できない' do
        @order_record_order.postal_code = '111111'
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('郵便番号に-(ハイフン)をつけてください')
      end
      it '市区町村が空だと保存できない' do
        @order_record_order.city = ''
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('市区町村を入力してください')
      end
      it '番地が空だと保存できない' do
        @order_record_order.address = ''
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が空だと保存できない' do
        @order_record_order.phone_number = ''
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('電話番号を入力してください')
      end
      it '都道府県を選択しないと保存できない' do
        @order_record_order.prefecture_id = 0
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'user_idは空では登録できない' do
        @order_record_order.user_id = nil
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idは空では登録できない' do
        @order_record_order.item_id = nil
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('Itemを入力してください')
      end
      it '電話番号は12桁以上では登録できない' do
        @order_record_order.phone_number = '111111111111'
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end
      it '電話番号は英数混合では登録できない' do
        @order_record_order.phone_number = '1111aaabbbc'
        @order_record_order.valid?
        expect(@order_record_order.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
    end
  end
end

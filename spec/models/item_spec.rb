require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができる場合' do
      it '全ての項目に適切な情報を入力すると出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it '商品画像が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を添付してください')
      end
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it '商品の説明が空では登録できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'カテゴリーを選択しないと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it '発送元の地域を選択しないと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it '発送までの日数を選択しないと登録できない' do
        @item.ship_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it '配送料の負担を選択しないと登録できない' do
        @item.shipping_cost_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it '商品の状態を選択しないと登録できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it '金額が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('金額を入力してください')
      end
      it '金額が¥300以上でないと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('金額は¥300~¥9,999,999で入力してください')
      end
      it '金額が¥9,999,999以内でないと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('金額は¥300~¥9,999,999で入力してください')
      end
      it '金額が半角数字でないと登録できない' do
        @item.price = '５０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('金額は半角数字で入力してください')
      end
      it '半角英語では登録できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('金額は半角数字で入力してください')
      end
      it '半角英数混合では登録できないこと' do
        @item.price = '3000yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('金額は半角数字で入力してください')
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end

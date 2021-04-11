require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '商品購入', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_record_order = FactoryBot.build(:order_record_order)
    @image_path = Rails.root.join('public/images/dummy.png')
  end
  context '商品を購入できる時'do
    it 'ログインしたユーザーは商品を購入できる' do
      # ログインする
      basic_pass root_path
      sign_in(@user)
      # 別のユーザの商品詳細ページに遷移する
      find('.item-lists').click
      # 購入画面に遷移するリンクがあることを確認する
      expect(page).to have_link('購入画面に進む')
      # 購入画面に遷移する
      click_on('購入画面に進む')
      # フォームに情報を入力する
      fill_in 'order_record_order[card_number]', with: 4242424242424242
      fill_in 'order_record_order[card_exp_month]', with: 10
      fill_in 'order_record_order[card_exp_year]', with: 33
      fill_in 'order_record_order[card_cvc]', with: 123
      fill_in 'order_record_order[receiver]', with: @order_record_order.receiver
      fill_in 'order_record_order[postal_code]', with: @order_record_order.postal_code
      select @item.prefecture.name, from: 'order_record_order[prefecture_id]'
      fill_in 'order_record_order[city]', with: @order_record_order.city
      fill_in 'order_record_order[address]', with: @order_record_order.address
      fill_in 'order_record_order[phone_number]', with: @order_record_order.phone_number
      # 購入ボタンをクリックする
      click_on('購入')
      # トップページの購入した商品に'Sold Out!!'の文字が表示されていることを確認する。
      expect(page).to have_content('Sold Out!!')
      # 購入した商品詳細ページに遷移する
      find('.item-lists').click
      # 商品に'Sold Out!!'の文字が表示されていることを確認する。
      expect(page).to have_content('Sold Out!!')
      # 購入ページに遷移するリンクがないことを確認する
      expect(page).to have_no_link('購入画面に進む')
      # 出品したユーザの詳細ページへ遷移する
      click_on(@item.user.nickname)
      # ユーザ詳細ページの購入した商品に'Sold Out!!'の文字が表示されていることを確認する。
      expect(page).to have_content('Sold Out!!')
    end
  end
  context '商品を購入できないとき'do
  it 'ログインしていないと購入ボタンが表示されない' do
    # トップページに移動する
    basic_pass root_path
    # 商品詳細ページに遷移する
    find('.item-lists').click
    # 購入ページに遷移するリンクがないことを確認する
    expect(page).to have_no_link('購入画面に進む')
  end
  it '適切な情報を入力しないと購入できない' do
    # ログインする
    basic_pass root_path
    sign_in(@user)
    # 別のユーザの商品詳細ページに遷移する
    find('.item-lists').click
    # 購入画面に遷移するリンクがあることを確認する
    expect(page).to have_link('購入画面に進む')
    # 購入画面に遷移する
    click_on('購入画面に進む')
    # フォームに情報を入力する
    fill_in 'order_record_order[card_number]', with: nil
    fill_in 'order_record_order[card_exp_month]', with: nil
    fill_in 'order_record_order[card_exp_year]', with: nil
    fill_in 'order_record_order[card_cvc]', with: nil
    fill_in 'order_record_order[receiver]', with: ''
    fill_in 'order_record_order[postal_code]', with: ''
    fill_in 'order_record_order[city]', with: ''
    fill_in 'order_record_order[address]', with: ''
    fill_in 'order_record_order[phone_number]', with: ''
    # 購入ボタンをクリックする
    click_on('購入')
    # 購入するのボタンを押してもitemモデルのカウントが上がらないことを確認する
    expect{find('input[name="commit"]').click}.to change { OrderRecord.count }.by(0)
    # 出品ページへ戻されることを確認する
    expect(current_path).to eq(item_orders_path(@item.id))
    end
  end
end
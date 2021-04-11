require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @image_path = Rails.root.join('public/images/dummy.png')
  end
  context '商品を出品できる時'do
    it 'ログインしたユーザーは商品を出品できる' do
      # ログインする
      basic_pass root_path
      sign_in(@user)
      # 出品するアイコンをクリックする。
      find('.purchase-btn').click
      # 出品ページへ移動することを確認する
      expect(current_path).to eq(new_item_path)
      # フォームに情報を入力する
      new_item(@item)
      # 出品するとitemモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Item.count }.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど出品した商品が存在することを確認する（画像）
      expect(page).to have_selector('img')
      # トップページには先ほど出品した商品の内容が存在することを確認する（商品名）
      expect(page).to have_content(@item.name)
      # トップページには先ほど出品した商品の内容が存在することを確認する（価格）
      expect(page).to have_content(@item.price)
      # トップページには先ほど出品した商品の内容が存在することを確認する（配送料）
      expect(page).to have_content(@item.shipping_cost.name)
      # 詳細ページに出品した商品が表示されることを確認する
      click_on(@user.nickname)
      expect(page).to have_selector('img')
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
    end
  end
  context '商品を出品できないとき'do
    it 'ログインしていないと出品ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      # 出品ページへ移動しようとするとログインページに遷移することを確認する
      find('.purchase-btn').click
      expect(current_path).to eq(new_user_session_path)
    end
    it '適切な情報を入力しないと出品できない' do
      # ログインする
      basic_pass root_path
      sign_in(@user)
      # 出品するアイコンをクリックする。
      find('.purchase-btn').click
      # フォームに情報を入力する
      fill_in 'item[name]', with: ''
      fill_in 'item[info]', with: ''
      fill_in 'item[price]', with: ''
      # 出品するのボタンを押してもitemモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Item.count }.by(0)
      # 出品ページへ戻されることを確認する
      expect(current_path).to eq(items_path)
    end
  end
end
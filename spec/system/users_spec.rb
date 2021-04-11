require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do

      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録をクリックしてページへ移動する
      click_on('新規登録')
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name_kana]', with: @user.last_name_kana
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      select '1930', from: 'user[birth_date(1i)]'
      select '1', from: 'user[birth_date(2i)]'
      select '1', from: 'user[birth_date(3i)]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが表示されてることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      # ログアウトボタンをクリックするとトップページに遷移することを確認する
      click_on('ログアウト')
      expect(current_path).to eq(root_path)
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録をクリックしてページへ移動する
      click_on('新規登録')
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      fill_in 'user[last_name]', with: ''
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name_kana]', with: ''
      fill_in 'user[first_name_kana]', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      click_on('ログイン')
      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      click_on('ログイン')
      # ユーザー情報を入力する
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'プロフィール編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context 'プロフィール編集ができるとき' do
    it '自分のプロフィールが編集ができる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      click_on('ログイン')
      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ログインしたユーザのニックネームが表示されることを確認する
      expect(page).to have_content("#{@user.nickname}")
      # ログインしたユーザのニックネームをクリックするとログインユーザの詳細ページへ遷移することを確認する
      click_on("#{@user.nickname}")
      expect(current_path).to eq(user_path(@user.id))
      # プロフィール編集画面が表示されていないことを確認する
      expect(page).to have_no_selector('.modal')
      # ログインしたユーザが自分の詳細ページに遷移するとプロフィール編集ボタンが表示されることを確認する
      expect(page).to have_selector("img[src='/assets/edit_button-c8f274a32db2db949cfb4763450b04bb1a24f8b8fb263add59687cc3049fd749.png']")
      # 編集ボタンを押すとプロフィール編集モーダルが表示されることを確認する
      find("img[src='/assets/edit_button-c8f274a32db2db949cfb4763450b04bb1a24f8b8fb263add59687cc3049fd749.png']").click
      expect(page).to have_selector('.modal')
      # 編集前のプロフィールが表示されていることを確認する
      expect(page).to have_field('user[profile]', with: "#{@user.profile}")
      # プロフィールを編集する
      fill_in 'user[profile]', with: ''
      fill_in 'user[profile]', with: Faker::Lorem.sentence
      # 更新するボタンが押されたら、プロフィール情報が更新されることを確認する
      click_on('更新する')
      expect(page).to have_content("#{@user_profile}")
    end
  end

  context 'プロフィール編集ができない' do
    it '自分以外のプロフィールは編集ができない' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      click_on('ログイン')
      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # 自分以外のユーザの詳細ページへ遷移する
      visit user_path(@user2.id)
      # 詳細ページにプロフィール編集ボタンが表示されていないことを確認する
      expect(page).to have_no_selector("img[src='/assets/edit_button-c8f274a32db2db949cfb4763450b04bb1a24f8b8fb263add59687cc3049fd749.png']")
    end

    it 'ログインしないとプロフィールは編集ができない' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # 登録済みのユーザの詳細ページへ遷移する
      visit user_path(@user.id)
      # 詳細ページにプロフィール編集ボタンが表示されていないことを確認する
      expect(page).to have_no_selector("img[src='/assets/edit_button-c8f274a32db2db949cfb4763450b04bb1a24f8b8fb263add59687cc3049fd749.png']")
    end
  end
end
# require 'rails_helper'

# RSpec.describe '購入フロー', type: :system do
#   before do
#     driven_by(:selenium_chrome_headless) # JS不要ならrack_testでOK。JS必要なら:selenium_chrome_headless 等に変更。
#     @seller = FactoryBot.create(:user)
#     @buyer  = FactoryBot.create(:user)
#     @item   = FactoryBot.create(:item, user: @seller, price: 1000)
#   end

#   it '正しく入力すると購入できトップに遷移する' do
#     # ログイン
#     login_as(@buyer, scope: :user) # Warden::Test::Helpers を使う場合 rails_helper に include が必要

#     # 購入ページへ
#     visit item_orders_path(@item)

#     # フォーム入力（フィールドの id/name はビューに合わせて調整してください）
#     fill_in 'postal_code', with: '123-4567'
#     select '東京都', from: 'shopping_record_form[prefecture_id]' # フォームのnameに合わせて調整
#     fill_in 'municipality', with: '渋谷区'
#     fill_in 'street_address', with: '神南1-1-1'
#     fill_in 'building_name', with: 'テストハイツ101'
#     fill_in 'phone_number', with: '09012345678'
#     page.execute_script("document.getElementById('token').value = 'tok_test_1234567890'")

#     # カード情報はPAY.JPで実際にトークン化する処理が必要。
#     # System spec では JS と PAY.JP のモックを用意するか、トークンフィールドを直接セットする実装にする。
#     # テスト用で token を hidden に注入する実装があればここでそれを行う。
#     page.execute_script("document.querySelector('input[name=\"token\"]').value = 'tok_test_1234567890'")

#     click_button '購入'
#     expect(current_path).to eq root_path
#     expect(page).to have_content '購入が完了しました' # コントローラでフラッシュを作っているなら
#   end
# end
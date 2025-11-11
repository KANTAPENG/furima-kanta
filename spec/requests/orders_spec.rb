require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "商品購入ページへのアクセス制御" do
    before do
      @seller = FactoryBot.create(:user)
      @buyer  = FactoryBot.create(:user)
      @item   = FactoryBot.create(:item, user: @seller)
    end

    context "ログアウト状態" do
      it "購入ページに行くとログインページにリダイレクトされる" do
        get item_orders_path(@item)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン状態" do
      it "出品者以外のユーザーは購入ページにアクセスできる" do
        sign_in @buyer
        get item_orders_path(@item)
        expect(response).to have_http_status(:ok)
      end

      it "出品者がアクセスするとトップページにリダイレクトされる" do
        sign_in @seller
        get item_orders_path(@item)
        expect(response).to redirect_to(root_path)
      end

      it "売却済みの商品はトップにリダイレクトされる" do
        # 売却済みを再現するために shopping_record を作る
        ShoppingRecord.create(user_id: @buyer.id, item_id: @item.id)
        sign_in @buyer
        get item_orders_path(@item)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
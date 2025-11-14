require 'rails_helper'

RSpec.describe ShoppingRecordForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @shopping_record_form = FactoryBot.build(:shopping_record_form, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@shopping_record_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @shopping_record_form.building_name = ''
        expect(@shopping_record_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと購入できない' do
        @shopping_record_form.postal_code = ''
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んでいないと購入できない' do
        @shopping_record_form.postal_code = '1234567'
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが1では購入できない' do
        @shopping_record_form.prefecture_id = 1
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空だと購入できない' do
        @shopping_record_form.municipality = ''
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'street_addressが空だと購入できない' do
        @shopping_record_form.street_address = ''
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Street address can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @shopping_record_form.phone_number = ''
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下だと購入できない' do
        @shopping_record_form.phone_number = '123456789'
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが12桁以上だと購入できない' do
        @shopping_record_form.phone_number = '123456789012'
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberに半角数字以外が含まれていると購入できない' do
        @shopping_record_form.phone_number = '０９０１２３４５６７８'
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'tokenが空では購入できない' do
        @shopping_record_form.token = ''
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Token を入力してください")
      end

      it 'user_idが空では購入できない' do
        @shopping_record_form.user_id = nil
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @shopping_record_form.item_id = nil
        @shopping_record_form.valid?
        expect(@shopping_record_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
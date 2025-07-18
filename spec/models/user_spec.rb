require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    let(:user) { build(:user) }

    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(user).to be_valid
      end
    end

    context '新規登録できないとき' do
      
      it 'nicknameが空では登録できない' do
        user.nickname = ''
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        user.password = ''
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      
      it 'passwordが5文字以下では登録できない' do
        user.password = 'a1234'
        user.password_confirmation = 'a1234'
        user.valid?
        expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      
      it 'passwordが半角英数字混合でないと登録できない（数字のみ）' do
        user.password = '123456'
        user.password_confirmation = '123456'
        user.valid?
        expect(user.errors.full_messages).to include("Password は半角英字と数字の両方を含めて設定してください")
      end

      
      it 'passwordが半角英数字混合でないと登録できない（英字のみ）' do
        user.password = 'abcdef'
        user.password_confirmation = 'abcdef'
        user.valid?
        expect(user.errors.full_messages).to include("Password は半角英字と数字の両方を含めて設定してください")
      end

      
      it 'passwordに全角文字が含まれていると登録できない' do
        user.password = 'abc１２３'
        user.password_confirmation = 'abc１２３'
        user.valid?
        expect(user.errors.full_messages).to include("Password は半角英字と数字の両方を含めて設定してください")
      end

     
      it 'last_nameが空では登録できない' do
        user.last_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end

      
      it 'last_nameが全角でないと登録できない' do
        user.last_name = 'abc'
        user.valid?
        expect(user.errors.full_messages).to include("Last name は全角文字を使用してください")
      end

      
      it 'first_nameが空では登録できない' do
        user.first_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

     
      it 'first_nameが全角でないと登録できない' do
        user.first_name = 'abc'
        user.valid?
        expect(user.errors.full_messages).to include("First name は全角文字を使用してください")
      end

      it 'last_name_kanaが空では登録できない' do
        user.last_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      
      it 'last_name_kanaがカタカナでないと登録できない' do
        user.last_name_kana = 'やまだ'
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana は全角カタカナを使用してください")
      end

     
      it 'first_name_kanaが空では登録できない' do
        user.first_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end

      
      it 'first_name_kanaがカタカナでないと登録できない' do
        user.first_name_kana = 'たろう'
        user.valid?
        expect(user.errors.full_messages).to include("First name kana は全角カタカナを使用してください")
      end

  
      it 'birthdayが空では登録できない' do
        user.birthday = ''
        user.valid?
        expect(user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
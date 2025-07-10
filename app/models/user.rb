class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,           presence: true
  validates :email,              presence: true
  validates :encrypted_password, presence: true
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角文字を使用してください" }
  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角文字を使用してください" }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナを使用してください" }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナを使用してください" }
  validates :birthday,           presence: true
end

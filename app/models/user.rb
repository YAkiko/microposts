class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  # 名前 必須
  validates :name, presence: true, length: { maximum: 50 }
  # 地域
  validates :area , length: { minimum: 2, maximum: 30 } , presence: false

  # プロフィールは必須入力かつ2文字以上30文字以下
  validates :discription , length: { minimum: 2, maximum: 30 } , presence: false

  # email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # パスワード
  has_secure_password
  
end

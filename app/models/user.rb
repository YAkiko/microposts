class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  # 名前 必須
  validates :name, presence: true, length: { maximum: 50 }
  # 地域
  validates :area , length: { minimum: 2, maximum: 30 } , presence: false, on: :update

  # プロフィールは必須入力かつ2文字以上30文字以下
  validates :discription , length: { minimum: 2, maximum: 30 } , presence: false, on: :update

  # email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # パスワード
  has_secure_password
  
  # microposts
  has_many :microposts
  
  # フォロー
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
    # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
end

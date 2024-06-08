class User < ApplicationRecord
  # Deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  # アソシエーション
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  # DM機能のアソシエーション
  has_many :conversations, foreign_key: :sender_id
  has_many :messages

  # Active Storageの設定
  has_one_attached :profile_image

  # フォロー関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # グループ関連のアソシエーション
  has_many :groups
  has_many :group_users
  has_many :joined_groups, through: :group_users, source: :group
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id'

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 既にフォローしているか確認
  def following?(other_user)
    following.include?(other_user)
  end
end

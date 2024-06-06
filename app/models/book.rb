# app/models/book.rb
class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # デフォルト値の設定
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.views_count ||= 0
  end

  # 閲覧数を増加させるメソッド
  def increment_views_count
    self.increment!(:views_count)
  end
end

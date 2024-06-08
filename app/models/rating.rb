# app/models/rating.rb
class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :value, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :book_id, message: "has already rated this book" }
end

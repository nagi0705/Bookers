# app/models/conversation.rb
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :receiver_id }
  validate :mutual_follow

  private

  def mutual_follow
    unless sender.following?(receiver) && receiver.following?(sender)
      errors.add(:base, "You can only start a conversation with mutual followers")
    end
  end
end

# app/models/group_user.rb
class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user_id, uniqueness: { scope: :group_id, message: "You are already a member of this group" }
end

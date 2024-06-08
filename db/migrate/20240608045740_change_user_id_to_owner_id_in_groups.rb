class ChangeUserIdToOwnerIdInGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :user_id, :integer
    change_column_null :groups, :owner_id, false
  end
end

class RemoveUserIdFromGroupsAndAddOwnerId < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :user_id, :integer
    # add_column :groups, :owner_id, :integer, null: false unless column_exists?(:groups, :owner_id)
  end
end

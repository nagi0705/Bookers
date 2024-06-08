class AddOwnerToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :owner_id, :integer, null: false, foreign_key: true
    remove_column :groups, :user_id, :integer, if_exists: true # 既存のuser_idカラムを削除
  end
end

class RenameUsersIdToUserIdInCategories < ActiveRecord::Migration[7.2]
  def change
    rename_column :categories, :users_id, :user_id
  end
end

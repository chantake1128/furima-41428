class RenameColumnInTableName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :fast_name, :first_name
    rename_column :users, :fast_name_kana, :first_name_kana
  end
end

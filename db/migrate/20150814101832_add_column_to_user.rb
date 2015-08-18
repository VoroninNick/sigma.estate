class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :site_users, :subscribe, :boolean
  end
end

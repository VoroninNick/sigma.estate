class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :site_users, :username, :string
  end
end

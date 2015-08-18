class AddAvatarsToUsers < ActiveRecord::Migration
  def change
    change_table :site_users do |t|
        t.attachment :avatar
      end
  end
end

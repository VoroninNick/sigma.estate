class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.has_attached_file :image
      t.text :description
      t.text :short_description
      t.boolean :feature
      t.boolean :published

      t.timestamps null: false
    end
  end
end

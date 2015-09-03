class CreateSigmaApartments < ActiveRecord::Migration
  def change
    create_table :sigma_apartments do |t|
      t.boolean :published
      t.belongs_to :building_complex
      t.belongs_to :apartment_house
      t.string :apartment_number
      t.float :price

      t.string :building_premise_number
      t.string :world_sides
      t.string :apartment_type
      t.string :live_square
      t.text :turnkey

      # technical_info



      t.timestamps null: false
    end
  end
end

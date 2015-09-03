class CreateSigmaApartmentHouses < ActiveRecord::Migration
  def change
    create_table :sigma_apartment_houses do |t|
      t.boolean :published

      t.belongs_to :building_complex

      # address
      t.string :coordinates
      t.string :street
      t.string :street_number

      t.string :status

      t.date :building_start_date
      t.date :building_end_date


      t.float :price_from

      # technical info
      t.integer :levels_count
      t.integer :apartments_count


      # apartment defaults



      t.timestamps null: false
    end
  end
end

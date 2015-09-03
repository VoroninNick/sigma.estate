class CreateSigmaHouseTechnicalSettings < ActiveRecord::Migration
  def change
    create_table :sigma_house_technical_settings do |t|

      t.string :building_type
      t.integer :building_id


      t.text :operated_roof
      t.text :building_process_type
      t.integer :sections_count
      t.string :lift_mark
      t.text :devices_setup
      t.text :beautification
      t.text :video_surveillance_system
      t.string :parking_type
      t.integer :park_places_count
      t.text :apply_energy_saving_technologies

      t.timestamps null: false
    end
  end
end

class CreateSigmaApartmentTechnicalSettings < ActiveRecord::Migration
  def change
    create_table :sigma_apartment_technical_settings do |t|
      t.string :building_type
      t.integer :building_id

      t.text :exterior_walls
      t.text :apartment_separator_walls
      t.text :apartment_inner_separator_walls
      t.float :premises_height
      t.string :filling_openings_in_walls
      t.text :entrance_door
      t.text :windows
      t.text :telephony
      t.text :internet
      t.text :tv
      t.text :kitchen_stove_type
      t.text :wiring
      t.text :sanitary_equipment
      t.text :heating
      t.text :ventilation
      t.text :water_supply
      t.text :internal_sewer_system
      t.text :internal_finishing_work
      t.text :additional_info

      t.timestamps null: false
    end
  end
end

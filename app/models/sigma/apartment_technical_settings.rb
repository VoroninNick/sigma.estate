# == Schema Information
#
# Table name: sigma_apartment_technical_settings
#
#  id                              :integer          not null, primary key
#  building_type                   :string
#  building_id                     :integer
#  exterior_walls                  :text
#  apartment_separator_walls       :text
#  apartment_inner_separator_walls :text
#  premises_height                 :float
#  filling_openings_in_walls       :string
#  entrance_door                   :text
#  windows                         :text
#  telephony                       :text
#  internet                        :text
#  tv                              :text
#  kitchen_stove_type              :text
#  wiring                          :text
#  sanitary_equipment              :text
#  heating                         :text
#  ventilation                     :text
#  water_supply                    :text
#  internal_sewer_system           :text
#  internal_finishing_work         :text
#  additional_info                 :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#

class Sigma::ApartmentTechnicalSettings < ActiveRecord::Base
  attr_accessible *attribute_names
  extend CommonAttributeName

  self.table_name = :sigma_apartment_technical_settings

  belongs_to :building, polymorphic: true

  attr_accessible :building
end
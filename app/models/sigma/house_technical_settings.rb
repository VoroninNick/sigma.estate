
# == Schema Information
#
# Table name: sigma_house_technical_settings
#
#  id                               :integer          not null, primary key
#  building_type                    :string
#  building_id                      :integer
#  operated_roof                    :text
#  building_process_type            :text
#  sections_count                   :integer
#  lift_mark                        :string
#  devices_setup                    :text
#  beautification                   :text
#  video_surveillance_system        :text
#  parking_type                     :string
#  park_places_count                :integer
#  apply_energy_saving_technologies :text
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#

class Sigma::HouseTechnicalSettings < ActiveRecord::Base
  attr_accessible *attribute_names
  extend CommonAttributeName

  self.table_name = :sigma_house_technical_settings

  belongs_to :building, polymorphic: true



  attr_accessible :building

  extend Enumerize




end

# == Schema Information
#
# Table name: sigma_apartments
#
#  id                      :integer          not null, primary key
#  published               :boolean
#  building_complex_id     :integer
#  apartment_house_id      :integer
#  apartment_number        :string
#  price                   :float
#  building_premise_number :string
#  world_sides             :string
#  apartment_type          :string
#  live_square             :string
#  turnkey                 :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Sigma::Apartment < ActiveRecord::Base
  self.table_name = :sigma_apartments
  attr_accessible *attribute_names
  extend CommonAttributeName
  extend Enumerize

  has_one :technical_settings, class_name: "Sigma::ApartmentTechnicalSettings", as: :building
  #belongs_to :building_complex, class_name: "BuildingComplex"
  belongs_to :apartment_house, class_name: "Sigma::ApartmentHouse"

  has_one :building_complex, through: :apartment_house

  accepts_nested_attributes_for :technical_settings
  attr_accessible :technical_settings, :technical_settings_attributes

  attr_accessible :building_complex
  attr_accessible :apartment_house

  has_images :banner_images, styles: { thumbnail: "273x180#", large: "940x400#" }

  def next
    Apartment.where("id > ?", id).first
  end

  def prev
    Apartment.where("id < ?", id).last
  end


  def self.available_cities
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:city).uniq
  end


  enumerize :apartment_type, in: [:one_room, :two_rooms, :three_rooms, :four_rooms, :five_rooms_plus, :studio, :mansard, :two_levels]

  def street_address
    I18n.t("formats.street_address", street: apartment_house.street, street_number: apartment_house.street_number)
  end
end

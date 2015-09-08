# == Schema Information
#
# Table name: sigma_building_complexes
#
#  id                                      :integer          not null, primary key
#  name                                    :string
#  complex_class                           :string
#  coordinates                             :string
#  country                                 :string
#  city                                    :string
#  district                                :string
#  street                                  :string
#  street_number                           :string
#  status                                  :string
#  availability                            :string
#  building_start_date                     :date
#  building_end_date                       :date
#                              :integer
#  price_from                              :float
#  builder_site                            :string
#  phone                                   :string
#  distance_to_pre_school                  :text
#  distance_to_school                      :text
#  distance_to_food_markets                :text
#  playground                              :text
#  nearest_metro_station                   :text
#  nearest_bus_stop                        :text
#  earth_area_square                       :float
#  total_complex_square                    :float
#  total_live_square                       :float
#  total_accommodations_count              :integer
#  commerce_square_of_residential_premises :float
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#

class Sigma::BuildingComplex < ActiveRecord::Base
  self.table_name = :sigma_building_complexes
  attr_accessible *attribute_names
  extend CommonAttributeName
  extend Enumerize

  has_one :apartment_defaults, class_name: "Sigma::ApartmentTechnicalSettings", as: :building
  has_one :apartment_house_defaults, class_name: "Sigma::HouseTechnicalSettings", as: :building
  has_many :apartment_houses, class_name: "Sigma::ApartmentHouse"
  has_many :apartments, class_name: "Sigma::Apartment"

  accepts_nested_attributes_for :apartment_defaults
  accepts_nested_attributes_for :apartment_house_defaults

  attr_accessible :apartment_house_defaults, :apartment_house_defaults_attributes
  attr_accessible :apartment_defaults_attributes, :apartment_defaults
  attr_accessible :apartment_houses
  attr_accessible :apartments

  enumerize :status, in: [:building_in_process, :built, :project]

  enumerize :complex_class, in: [:delux, :club, :elite, :business, :comfort, :standard, :econom]
  enumerize :availability, in: [:available_apartments_or_square, :no_available_apartments, :add_project, :reservation]

  validates :complex_class, presence: true

  scope :with_available_apartments, -> { where(has_any: true) }

  has_images :banner_images, styles: {  thumbnail: "273x180#", large: "940x500#" }
  has_images :gallery_images, styles: { gallery_image: "1440x900#", gallery_thumb: "96x60#" }

  def apartment_houses_count
    apartment_houses.length
  end
end
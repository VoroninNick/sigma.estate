
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
  belongs_to :building_complex, class_name: "BuildingComplex"
  belongs_to :apartment_house, class_name: "Sigma::ApartmentHouse"

  #has_one :building_complex, through: :apartment_house

  accepts_nested_attributes_for :technical_settings
  attr_accessible :technical_settings, :technical_settings_attributes

  attr_accessible :building_complex
  attr_accessible :apartment_house

  has_images :banner_images, styles: { thumbnail: "273x180#", large: "940x400#" }

  def next
    Sigma::Apartment.where("id > ?", id).first
  end

  def prev
    Sigma::Apartment.where("id < ?", id).last
  end


  def self.available_cities
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:city).uniq
  end
  def self.available_districts
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:district).uniq
  end

  enumerize :apartment_type, in: [:one_room, :two_rooms, :three_rooms, :four_rooms, :five_rooms_plus, :studio, :mansard, :two_levels]

  def street_address
    I18n.t("formats.street_address", street: apartment_house.street, street_number: apartment_house.street_number)
  end

  paginates_per 12

#   for filtering
  filterrific(
      default_filter_params: { sorted_by: 'created_at_asc' },
      available_filters: [
          :sorted_by,
          :with_building_complex_name,
          :with_count_rooms,
          :with_city,
          :with_district
          # :search_query,
          # :with_country_id,
          # :with_created_at_gte
      ]
  )

  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
      when /^created_at_/
        order("sigma_apartments.created_at #{ direction }")
      # when /^name_/
      #   order("LOWER(sigma_apartments.street) #{ direction }")
      when /^building_complex_name_/
        order("LOWER(building_complex.name) #{ direction }").includes(:sigma_building_complexes)
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end

  }
  def self.options_for_sorted_by
    [
        # ['Name (a-z)', 'name_asc'],
        ['Дата створення (новіші перше)', 'created_at_desc'],
        ['Дата створення (старіші перші)', 'created_at_asc'],
        ['Назва комплексу (a-я)', 'building_complex_name_asc']
    ]
  end

  # building complex name
  scope :with_building_complex_name, lambda { |complex_id|
                         joins(:building_complex).where(sigma_building_complexes: { id: complex_id })
                        }
  # always include the lower boundary for semi open intervals
  scope :with_price_form, lambda { |price|
                         where('sigma_apartments.price <= ?', price)
                       }

  # always exclude the upper boundary for semi open intervals
  scope :with_price_end, lambda { |price|
                        where('sigma_apartments.price < ?', price)
                      }
  # count rooms
  scope :with_count_rooms, lambda { |count_rooms|
                         where(rooms_count: [*count_rooms])
                       }
  # filter by cities
  scope :with_city, lambda { |city|
                         joins(:building_complex).where(sigma_building_complexes: { city: city })
                       }
 # building complex name
  scope :with_district, lambda { |district|
                         joins(:building_complex).where(sigma_building_complexes: { district: district })
                       }


end

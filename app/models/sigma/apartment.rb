
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

  has_and_belongs_to_many :users, class_name: Sigma::User, join_table: :favorites



  #has_one :building_complex, through: :apartment_house

  accepts_nested_attributes_for :technical_settings
  attr_accessible :technical_settings, :technical_settings_attributes

  attr_accessible :building_complex
  attr_accessible :apartment_house

  has_images :banner_images, styles: { thumbnail: "273x180#", large: "940x400#" }
  has_attachment :pdf_file

  def next
    Sigma::Apartment.where("id > ?", id).first
  end

  def prev
    Sigma::Apartment.where("id < ?", id).last
  end

  def self.available_countries
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:country).uniq
  end
  def self.available_cities
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:city).uniq
  end
  def self.available_districts
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:district).uniq
  end
  def self.available_levels
    Sigma::Apartment.pluck(:level).uniq.select(&:present?).sort
  end

  enumerize :apartment_type, in: [:one_room, :two_rooms, :three_rooms, :four_rooms, :five_rooms_plus, :studio, :mansard, :two_levels]

  def street_address
    I18n.t("formats.street_address", street: apartment_house.street, street_number: apartment_house.street_number)
  end

  paginates_per 12


#   sunspot
#   searchable do
#     text        :html_description
#     text        :infrastructure_description_html
#     text        :main_description_html
#     integer     :building_complex_id, :references => Sigma::BuildingComplex
#   end

#   for filtering
  filterrific(
      # default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :with_building_complex_name,
          :with_count_rooms,
          :with_city,
          :with_district,
          :with_level,
          :with_price_from,
          :with_price_to,
          :with_total_square_from,
          :with_total_square_to,
          :search_query
      ]
  )
  scope :search_query, lambda { |query|
                       return nil  if query.blank?
                       terms = query.downcase.split(/\s+/)
                       terms = terms.map { |e|
                         (e.gsub('*', '%') + '%').gsub(/%+/, '%')
                       }

                       num_or_conditions = 1
                       where(
                           terms.map {
                             or_clauses = [
                                 "LOWER(sigma_apartments.id) LIKE ?"
                             ].join(' OR ')
                             "(#{ or_clauses })"
                           }.join(' AND '),
                           *terms.map { |e| [e] * num_or_conditions }.flatten
                       )

                     }
  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
      when /^created_at_/
        order("sigma_apartments.created_at #{ direction }")
      when /^building_complex_street_/
        joins(:building_complex).order("LOWER(sigma_building_complexes.street) #{ direction }")
      when /^building_complex_name_/
        # order("LOWER(sigma_building_complexes.name) #{ direction }").includes(:building_complex)
        joins(:building_complex).order("LOWER(sigma_building_complexes.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end

  }
  def self.options_for_sorted_by
    [
        ['Дата створення (старіші перші)', 'created_at_asc'],
        ['Дата створення (новіші перші)', 'created_at_desc'],
        ['Назва комплексу (a-я)', 'building_complex_name_asc'],
        ['Назва комплексу (я-а)', 'building_complex_name_desc'],
        ['Назва вулиці (а-я)', 'building_complex_street_asc'],
        ['Назва вулиці (я-а)', 'building_complex_street_desc']
    ]
  end

  # building complex name
  scope :with_building_complex_name, lambda { |complex_id|
                         joins(:building_complex).where(sigma_building_complexes: { id: complex_id })
                        }
  # always include the lower boundary for semi open intervals
  scope :with_price_from, lambda { |price|
                         where('sigma_apartments.price >= ?', price)
                       }

  # always exclude the upper boundary for semi open intervals
  scope :with_price_to, lambda { |price|
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
 # apartment level
  scope :with_level, lambda { |level|
                         where(level: level)
                       }

  scope :with_total_square_from, lambda { |total_square|
                                 where('sigma_apartments.total_square >= ?', total_square)
                               }
  scope :with_total_square_to, lambda { |total_square|
                                 where('sigma_apartments.total_square < ?', total_square)
                               }


end

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

  belongs_to :builder, :class_name => 'Sigma::Builder'
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


  def next
    Sigma::BuildingComplex.where("id > ?", id).first
  end

  def prev
    Sigma::BuildingComplex.where("id < ?", id).last
  end
  def apartment_houses_count
    apartment_houses.length
  end

  def self.available_cities
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:city).uniq
  end
  def self.available_districts
    # BuildingComplex.pluck(:city, :district).uniq.group_by("city")
    Sigma::BuildingComplex.pluck(:district).uniq
  end

  paginates_per 12

  searchable do
    text        :name, :city, :street, :main_description_html
  end
#   =================================================
  def self.options_for_select_complex_class
    order('LOWER(complex_class)').map { |e| [e.complex_class] }.uniq
  end
  def self.options_for_select_city
    order('LOWER(city)').map { |e| [e.city] }.uniq
  end
  def self.options_for_select_street
    order('LOWER(street)').map { |e| [e.street] }.uniq
  end
  def self.options_for_select_district
    order('LOWER(district)').map { |e| [e.district] }.uniq
  end
  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end


#   for filtering
  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :with_city,
          :with_district,
          :with_street,
          :with_price_from,
          :with_price_to,
          :with_complex_class
      ]
  )

  scope :sorted_by, lambda { |sort_key|
                    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
                    case sort_key.to_s
                      when /^created_at_/
                        order("sigma_building_complexes.created_at #{ direction }")
                      # when /^street_/
                      #   joins(:building_complex).order("LOWER(sigma_building_complexes.street) #{ direction }")
                      # when /^name_/
                      #   # order("LOWER(sigma_building_complexes.name) #{ direction }").includes(:building_complex)
                      #   joins(:building_complex).order("LOWER(sigma_building_complexes.name) #{ direction }")
                      else
                        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
                    end

                  }
  def self.options_for_sorted_by
    [
        ['Дата створення (старіші перші)', 'created_at_asc'],
        ['Дата створення (новіші перші)', 'created_at_desc']
        # ['Назва комплексу (a-я)', 'building_complex_name_asc'],
        # ['Назва комплексу (я-а)', 'building_complex_name_desc'],
        # ['Назва вулиці (а-я)', 'building_complex_street_asc'],
        # ['Назва вулиці (я-а)', 'building_complex_street_desc']
    ]
  end

# filter by complex_class
  scope :with_complex_class, lambda { |complex_class|
                    where(complex_class: complex_class)
                  }
# filter by cities
  scope :with_city, lambda { |city|
                    where(city: city)
                  }
# building complex name
  scope :with_district, lambda { |district|
                        where(district: district )
                      }
# filter by street
  scope :with_street, lambda { |street|
                      where(street: street)
                    }
# always include the lower boundary for semi open intervals
  scope :with_price_from, lambda { |price|
                          where('price_from >= ?', price)
                        }
# always exclude the upper boundary for semi open intervals
  scope :with_price_to, lambda { |price|
                        where('price_from < ?', price)
                      }
end
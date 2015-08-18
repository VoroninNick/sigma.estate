
# == Schema Information
#
# Table name: apartment_houses
#
#  id         :integer          not null, primary key
#  complex_id :integer
#  price_from :float
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ApartmentHouse < ActiveRecord::Base
  # acts_as_apartment_house
  # acts_as_house
  has_many :apartments
  belongs_to :building_complex, foreign_key: :complex_id, class_name: "BuildingComplex"
end
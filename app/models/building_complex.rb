# == Schema Information
#
# Table name: building_complexes
#
#  id         :integer          not null, primary key
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BuildingComplex < ActiveRecord::Base
  extend Enumerize


  has_many :apartment_houses, foreign_key: :complex_id
  # acts_as_building_complex
  has_one :apartment_technical_info, class_name: "ApartmentTechnicalInfo", as: :actable_as_apartment, autosave: true


  enumerize :status, in: [:building_in_process, :built, :project]
end
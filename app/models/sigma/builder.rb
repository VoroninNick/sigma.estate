class Sigma::Builder < ActiveRecord::Base
  self.table_name = :sigma_builders
  has_many :complexes, :class_name => 'Sigma::BuildingComplex'
end
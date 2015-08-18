class ApartmentTechnicalInfo < ActiveRecord::Base
  belongs_to :actable_as_apartment, polymorphic: true

end
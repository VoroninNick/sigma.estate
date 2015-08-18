
class Apartment < ActiveRecord::Base

  has_one :apartment_technical_info, as: 'actable_as_apartment'

  def self.acts_as_apartment
      belongs_to :apartment_house
      has_one :address, as: :addressable, class_name: "Address"
  end

  acts_as_apartment

  def next
    Apartment.where("id > ?", id).first
  end

  def prev
    Apartment.where("id < ?", id).last
  end

  def tech_info
    res = self.apartment_technical_info
    res ||= self.apartment_house.try{|h| apartment_technical_info }
    res ||= self.apartment_house.building_complex.apartment_technical_info
  end
end
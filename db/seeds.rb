# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'


50.times do |c_i|
  c = BuildingComplex.new
  c.name = FFaker::Company.name
  c.status = [:building_in_process, :built, :project].sample
  # main info
  c.complex_class = [:delux, :club, :elite, :business, :comfort, :standard, :econom].sample
  c.availability = [:available_apartments_or_square, :no_available_apartments].sample
  c.building_start_date = FFaker::Time.date
  c.building_end_date = c.building_start_date + [6,12,18,24].sample.months
  c.price_from = rand(1000.0..100000.0)
  c.phone = FFaker::PhoneNumber.short_phone_number
  c.earth_area_square = rand(50.0..300.0)
  c.city = FFaker::Address.city
  c.builder_site = 'google.com'
  c.houses_count = rand(1..8)


  5.times do |h_i|
    h = ApartmentHouse.new
    h.street = FFaker::Address.street_name
    h.street_number = ['11','22','22a', '99d'].sample


    50.times do |a_i|
      a = Apartment.new
      a.apartment_type = Apartment.apartment_type.values.sample
      a.price = rand(8000..21000.0)
      a.live_square = rand(35..190)
      ats = a.build_technical_settings
      ats.heating = ['Індивідуальне', 'Центральне'].sample
      ats.exterior_walls = ['Цегла', 'Газобетон', 'Шлакоблоки'].sample

      h.apartments << a
    end

    c.apartment_houses << h
  end


  c.save
end
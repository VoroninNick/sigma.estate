module MainHelper
  def a_available_countries
    cities = Sigma::Apartment.available_countries
  end
  def a_available_cities
    cities = Sigma::Apartment.available_cities
  end
  def a_available_districts
    districts = Sigma::Apartment.available_districts
  end
end

class MainController < ApplicationController
  layout "stub", only: [:index]

  add_breadcrumb "Sigma Estate", :root_path

  def index
  end

  def apartment
    add_breadcrumb "Apartment", apartment_path
    @apartments = Apartment.limit(18)

    @building_complex = BuildingComplex.limit(5)
  end
  def apartment_catalog
    @apartments = Apartment.limit(18).page(params[:page]).per(12)
  end
  def apartment_item
    @apartment = Apartment.find(params[:id])
    @similar = Apartment.where.not(id: @apartment.id).limit(9)
  end

  def complex
    @building_complex = BuildingComplex.limit(20)
  end
  def complex_catalog
  end
  def complex_catalog_item
  end


  def about

  end
  def calculators

  end
  def contacts
    add_breadcrumb "Контакти", contacts_path
  end

  def comparison

  end

  def cabinet

  end

end

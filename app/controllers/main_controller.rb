class MainController < ApplicationController
  layout "stub", only: [:index]

  add_breadcrumb "Sigma Estate", :root_path

  def index
  end

  def apartment
    add_breadcrumb "Apartment", apartment_path
    @apartments = Apartment.limit(18)
  end
  def apartment_catalog
    @apartments = Apartment.limit(18)
  end
  def apartment_item
    @apartment = Apartment.find(params[:id])
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

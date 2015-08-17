class MainController < ApplicationController
  layout "stub", only: [:index]

  add_breadcrumb "Sigma Estate", :root_path
  def index
  end

  def apartment
    add_breadcrumb "Apartment", apartment_path
  end
  def apartment_catalog
  end
  def apartment_item

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

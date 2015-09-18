class MainController < ApplicationController
  layout "stub", only: [:index]

  add_breadcrumb "Sigma Estate", :root_path

  def index
  end

  def apartment
    add_breadcrumb "Apartment", apartment_path
    @banner = Banner.first
    @apartments = Sigma::Apartment.limit(18)

    @building_complex = Sigma::BuildingComplex.limit(5)
  end

  def apartment_catalog
    # @apartments = Sigma::Apartment.limit(18).page(params[:page]).per(12)

    @filterrific = initialize_filterrific(
      Sigma::Apartment,
      params[:filterrific],
      select_options: {
          sorted_by: Sigma::Apartment.options_for_sorted_by,
          with_building_complex_name: Sigma::BuildingComplex.options_for_select,
          with_city: Sigma::BuildingComplex.options_for_select_city,
          with_district: Sigma::BuildingComplex.options_for_select_district
      }
      ) or return
    @apartments = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def apartment_item
    @apartment = Sigma::Apartment.find(params[:id])
    @similar = Sigma::Apartment.where.not(id: @apartment.id).limit(9)
  end

  def complex
    @banner = Banner.first
    @building_complex = Sigma::BuildingComplex.limit(20)
  end
  def complex_catalog
  end
  def complex_catalog_item
    @building_complex = Sigma::BuildingComplex.find(params[:id])
  end


  def about
    @page = PageAboutCompany.first
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


  def have_questions_email
    name = params[:name]
    phone = params[:phone]
    email = params[:email]
    message = params[:message]
    ContactMailer.have_questions(name, phone, email, message).deliver

  end
  def call_to_order_email
    user_name = params[:username]
    phone_number = params[:phone]
    ContactMailer.call_to_order(user_name, phone_number).deliver
  end
  def book_review_email
  end


  def dev
    @search = Sunspot.search(Sigma::Apartment) do
      fulltext params[:search]
    end
    @apartments = @search.results
  end
end

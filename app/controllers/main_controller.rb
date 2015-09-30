class MainController < ApplicationController
  layout "stub", only: [:index]

  add_breadcrumb "Sigma Estate", :root_path

  def index
    @search = Sunspot.search [Sigma::Apartment, Sigma::BuildingComplex] do
      fulltext params[:search]
    end

    if @search.results.any?
      @apartments = @search.results
    else
      return redirect_to request_path
    end

  end

  def apartment

    add_breadcrumb "Apartment", apartment_path
    @banner = Banner.first
    @apartments = Sigma::Apartment.limit(18)

    @building_complex = Sigma::BuildingComplex.limit(5)
  end

  def apartment_catalog
    @search = Sunspot.search(Sigma::Apartment) do
      fulltext params[:search] do
        fields(:html_description, :infrastructure_description_html, :main_description_html, :building_complex)
      end
      with(:rooms_count, params[:rooms_count]) if params[:rooms_count].present?
    end
    @apartments = @search.results

    @filterrific = initialize_filterrific(
      Sigma::Apartment,
      params[:filterrific],
      select_options: {
          sorted_by: Sigma::Apartment.options_for_sorted_by,
          search_query: Sigma::Apartment,
          with_building_complex_name: Sigma::BuildingComplex.options_for_select,
          with_city: Sigma::BuildingComplex.options_for_select_city,
          with_street: Sigma::BuildingComplex.options_for_select_street,
          with_district: Sigma::BuildingComplex.options_for_select_district
      }
      ) or return

    @apartments_ar_relation = Sigma::Apartment.where( id: @apartments.map(&:id))

    @apartments = @apartments_ar_relation.filterrific_find(@filterrific)
    @apartments = @apartments.page(params[:page])

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
    @search = Sunspot.search(Sigma::BuildingComplex) do
      fulltext params[:search] do
        fields(:name, :city, :street, :main_description_html)
      end
    end
    @building_complexes = @search.results

    @filterrific = initialize_filterrific(
        Sigma::BuildingComplex,
        params[:filterrific],
        select_options: {
            sorted_by: Sigma::BuildingComplex.options_for_sorted_by,
            with_city: Sigma::BuildingComplex.options_for_select_city,
            with_district: Sigma::BuildingComplex.options_for_select_district,
            with_street: Sigma::BuildingComplex.options_for_select_street,
            with_complex_class: Sigma::BuildingComplex.options_for_select_complex_class
        },
        :persistence_id => false,
    ) or return

    @building_complex_ar_relation = Sigma::BuildingComplex.where( id: @building_complexes.map(&:id))

    @building_complexes = @building_complex_ar_relation.filterrific_find(@filterrific)
    @building_complexes = @building_complexes.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
  def complex_catalog_item
    @building_complex = Sigma::BuildingComplex.find(params[:id])
    @similar_building_complex = Sigma::BuildingComplex.where.not(id: @building_complex.id).where(district: @building_complex.district).limit(4)
    @other_building_complex = Sigma::BuildingComplex.where.not(id: @building_complex.id).limit(4)
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
    apartment_id = params[:apartment_id]
    user_name = params[:username]
    phone_number = params[:phone]
    date = params[:date]
    time_from = params[:time_from]
    time_to = params[:time_to]
    message = params[:message]

    ContactMailer.book_review(apartment_id, user_name, phone_number, date, time_from, time_to, message).deliver
  end


  def dev
    @search = Sunspot.search(Sigma::Apartment) do
      fulltext params[:search] do
        fields(:html_description, :infrastructure_description_html, :main_description_html, :building_complex)
      end
      facet (:complex_name)
      facet (:city)
      facet (:street)
      with(:complex_name, params[:roomscount]) if params[:roomscount].present?
      with(:city, params[:city]) if params[:city].present?
      with(:street, params[:street]) if params[:street].present?
    end

    @apartments = @search.results
  end

  def favorites_apartment
    apartment = Sigma::Apartment.find(params[:id])
    if current_user
      if !current_user.favorites.map(&:id).include? apartment.id
        current_user.favorites << apartment
      end
    end
    data = { success: true }
    status = 200
    status = 401 if !current_user
    render json: data, status: status
  end
  def remove_apartment_from_favorites
    apartment = Sigma::Apartment.find(params[:id])
    current_user.favorites.delete(apartment)

    data = { success: true }
    status = 200
    status = 401 if !current_user
    render json: data, status: status

  end

  def add_apartment_to_comparison
    @apartments = cookies[:apartments]
    if @apartments.blank?
      @apartments = cookies[:apartments] = params[:id]
    else
      cookies[:apartments] = { :value => @apartments + ',' + params[:id], :expires => 2.days.from_now, :lang => 'en-US'}
    end

    # @apartments = cookies[:apartments] || ""
    # apartment_ids = @apartments.split(",")
    # apartment_ids << params[:id]
    # cookies[:apartments] = apartment_ids.join(",")
  end

  def get_length_items_from_comparison
    @apartments_cook = cookies[:apartments] || ""

    apartment_ids = @apartments_cook.split(",").map(&:to_i)
    if apartment_ids.any?
      @apartments = Sigma::Apartment.find(*apartment_ids)
    end
    render :json => apartment_ids.length
  end
  def remove_apartment_from_comparison
    apartments_cook = cookies[:apartments] || ""
    apartment_ids = apartments_cook.split(",").map(&:to_i)

    apartment_id = params[:id].to_i

    apartment_ids.delete(apartment_id)
    cookies[:apartments] = { :value => apartment_ids.map(&:inspect).join(', '), :expires => 2.days.from_now, :lang => 'en-US'}
  end
end

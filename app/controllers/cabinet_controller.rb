class CabinetController < ApplicationController
  layout "cabinet_layout"

  def profile

  end

  def selected_realty
    @apartments = current_user.favorites
  end
  def calculators

  end
end

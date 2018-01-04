class LiftsController < ApplicationController
  def index
    @lifts = Lift.all.order(date_of_commissioned: :desc)
  end

  def import
    Lift.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

  def set_type
    Lift.set_type
    redirect_to root_url, notice: "Products imported."
  end
end

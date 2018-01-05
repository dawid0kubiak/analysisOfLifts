class LiftsController < ApplicationController
  def index
    @lifts = Lift.where('user_id = ?', current_user.id).order(date_of_commissioned: :desc)
  end

  def import
    Lift.import(params[:file], current_user.id)
    redirect_to root_url, notice: "Products imported."
  end

  def set_type
    Lift.set_type(current_user.id)
    redirect_to root_url, notice: "Products imported."
  end
end

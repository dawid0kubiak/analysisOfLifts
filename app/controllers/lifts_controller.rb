class LiftsController < ApplicationController
  include LiftsModule

  def index
    session[:i] = 0
    @lifts = Lift.where('user_id = ?', current_user.id).order(date_of_commissioned: :desc)
  end

  def import
    file = params[:file]
    import_lifts(file, current_user.id) unless file.nil?
    redirect_to root_url, notice: 'Products imported.'
  end

  def set_type
    set_type_lifts(current_user.id)
    redirect_to root_url, notice: 'Products imported.'
  end

end

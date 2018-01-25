class ReportsController < ApplicationController
  include ReportsModule
  before_action :init
  before_action :set_session, only: %w[all_operation cards]
  protect_from_forgery except: :show

  def cards
    @lifts = @lifts.where(transaction_type: 'Płatność kartą')
    @chart_data = chart_data @lifts
    @lifts = @lifts.order(date_of_commissioned: :desc)
  end

  def all_operation
    @lifts = @lifts.where('amount < 0').where(sql_date).where(@sql)
    @chart_data = chart_data @lifts
    @lifts = @lifts.order(date_of_commissioned: :desc)
  end

  private

  def init
    @lifts = Lift.where('user_id = ? and lift_type_id <> -2', current_user.id)
    @form_date = FormDate.new
  end

  def set_session
    session[:form_date] = params.require(:form_date).permit(:type, :start, :stop) if params.keys.include? 'form_date'
    session[:sql] = sql_build unless (params.keys & %w[simple product value]).empty?
    session.delete(:sql) if params.keys.include? 'clear_sql'
    session.delete(:form_date) if params.keys.include? 'clear_date'
    @form_date = FormDate.new(session[:form_date])
    @sql = session[:sql]
  end
end

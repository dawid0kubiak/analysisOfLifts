class ReportsController < ApplicationController
  before_action :init
  protect_from_forgery except: :show

  def cards
    @lifts = @l.where(transaction_type: 'Płatność kartą').order(date_of_commissioned: :desc)

    @nameData = @lifts.group(:name).select(:name, :amount).sum(:amount)
                    .map {|data| {value: data[1].abs, label: data[0]}}.to_json

    @typeData = @lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount)
                    .map {|data| {value: data[1].abs, label: LiftType.find(data[0]).name}}.to_json

  end

  def all_operation
    @lifts = @l.where('amount < 0').order(date_of_commissioned: :desc)

    @nameData = @lifts.group(:name).select(:name, :amount).sum(:amount)
                    .map {|data| {value: data[1].abs, label: data[0]}}.to_json

    @typeData = @lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount)
                    .map {|data| {value: data[1].abs, label: LiftType.find(data[0]).name}}.to_json

  end

  def add_form
    session[:i] = session[:i].to_i + 1
    #   aa = render_to_string('_form', dane: 'start')
    # render js: "$('#insert').append('#{render_to_string('_form', dane: 'start').gsub("\n", ' ')}');"
    render inline: "location.reload();"
    #   redirect_to all_operation
  end

  def sub_form
    session[:i] = session[:i].to_i - 1
    render inline: "location.reload();"
  end

  private

  def init
    @pieSize = {height: 400, width: 600}
    @l = Lift.where('user_id = ? and lift_type_id <> -2', current_user.id)
    @i = session[:i] > 1 ? session[:i] : 1
  end
end

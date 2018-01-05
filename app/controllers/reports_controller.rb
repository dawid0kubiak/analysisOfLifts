class ReportsController < ApplicationController
  before_action :init

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

  private

  def init
    @pieSize = {height: 400, width: 600}
    @l = Lift.where('user_id = ? and lift_type_id <> -2', current_user.id)
  end
end

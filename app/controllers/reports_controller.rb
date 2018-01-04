class ReportsController < ApplicationController
  before_action :init

  def cards
    @lifts = Lift.where(transaction_type: 'Płatność kartą').order(date_of_commissioned: :desc)

    colors = {
        red: {color: "#F7464A", highlight: "#FF5A5E"},
        green: {color: "#46BFBD", highlight: "#5AD3D1"},
        yellow: {color: "#FDB45C", highlight: "#FFC870"},
        grey: {color: "#949FB1", highlight: "#A8B3C5"},
        dark_grey: {color: "#4D5360", highlight: "#616774"}
    }

    @nameData = @lifts.group(:name).select(:name, :amount).sum(:amount)
                    .map {|data| {value: data[1].abs, label: data[0]}}.to_json

    @typeData = @lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount)
                    .map {|data| {value: data[1].abs, label: LiftType.find(data[0]).name}}.to_json

  end

  private

  def init
    @pieSize = {height: 400, width: 600}
  end
end

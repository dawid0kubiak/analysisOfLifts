class ReportsController < ApplicationController
  def cards
    @lifts = Lift.where(transaction_type: 'Płatność kartą').order(date_of_commissioned: :desc)
    @pieSize = {height: 400, width: 400}

    colors = {
        red: {color: "#F7464A", highlight: "#FF5A5E"},
        green: {color: "#46BFBD", highlight: "#5AD3D1"},
        yellow: {color: "#FDB45C", highlight: "#FFC870"},
        grey: {color: "#949FB1", highlight: "#A8B3C5"},
        dark_grey: {color: "#4D5360", highlight: "#616774"}
    }

    data_pie_del = @lifts.group(:name).select(:name, :amount).sum(:amount)
    @pieData = data_pie_del.map {|data| {value: data[1].abs, label: data[0]}}.to_json

    data_type = @lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount)
    @typeData = data_type.map {|data| {value: data[1].abs, label: LiftType.find(data[0]).name}}.to_json

  end
end

class ReportsController < ApplicationController
  def cards
    @lifts = Lift.where(transaction_type: 'Płatność kartą').order(date_of_commissioned: :desc)
    @pieSize = { height: 400, width: 400 }

    colors = {
        red: {color:"#F7464A", highlight: "#FF5A5E"},
        green: {color:"#46BFBD", highlight: "#5AD3D1"},
        yellow: {color:"#FDB45C", highlight: "#FFC870"},
        grey: {color:"#949FB1", highlight: "#A8B3C5"},
        dark_grey: {color:"#4D5360", highlight: "#616774"}
    }

    data_pie_del = @lifts.group(:name).select(:name, :amount).sum(:amount)


@pieData = data_pie_del.map { |data|   { value: data[1].abs, label: data[0] }}.to_json


    #     { value: 0.96499e3, label: "Red" },
    #     { value: 0.28798e3, label: "Green"},
    #     { value: 0.12823e3, label: "Yellow" },
    #     { value: 0.5032e2, label: "Grey" },
    #     { value: 0.3844e2, label: "Dark Grey" }
    #
    # ].to_json
  end
end

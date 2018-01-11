class ReportsController < ApplicationController
  before_action :init
  protect_from_forgery except: :show

  def cards
    @lifts = @lifts.where(transaction_type: 'Płatność kartą')
    @chart_data = chart_data @lifts
  end

  def all_operation
    @sql = sql_build
    @lifts = @lifts.where('amount < 0').where(@sql)
    @chart_data = chart_data @lifts

  end

  private

  def chart_data(lifts)
    name_data = lifts.group(:name).select(:name, :amount).sum(:amount)
                    .map {|data| {
                        value: data[1].abs, label: data[0]}}.to_json

    data = lifts.group(:name).select(:name, :amount).sum(:amount)
    sum = data.map{|d| d[1]}.sum

    type_data = lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount)
                    .map {|data| {
                        value: data[1].abs, label: "% ".html_safe+LiftType.find(data[0]).name}}.to_json
    {size: {height: 300, width: 500}, name: name_data, type: type_data}
  end

  def sql_build
    sql = ''
    if params.keys.include? 'simple'
      simples = params[:simple]
      simples.each do |simple|
        sql = where_build simple, sql
      end
    elsif params.keys.include? 'product'
      sql = LiftType.find(params[:product]).condition
    elsif params.keys.include? 'value'
      sql = params[:value]
    end
    sql
  end

  def init
    @lifts = Lift.where('user_id = ? and lift_type_id <> -2', current_user.id).order(date_of_commissioned: :desc)
  end

  def where_build(simple, sql)
    filed = simple[:filed]
    condition = simple[:condition]
    value = simple[:value]
    operator = simple[:operator]

    sql += case condition
             when /like/
               filed + ' ' + condition + ' "%' + value + '%" ' + add_oper(operator)
             else
               filed + ' ' + condition + ' "' + value + '" ' + add_oper(operator)
           end
    sql
  end

  def add_oper(operator)
    oper = ''
    oper += operator + ' ' unless operator.nil?
    oper + ' '
  end
end

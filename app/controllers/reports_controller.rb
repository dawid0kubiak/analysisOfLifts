class ReportsController < ApplicationController
  before_action :init
  protect_from_forgery except: :show

  def cards
    @chart_data = chart_data @lifts
    @lifts = @lifts.where(transaction_type: 'Płatność kartą').order(date_of_commissioned: :desc)
  end

  def all_operation
    @sql = sql_build
    @chart_data = chart_data @lifts
    @lifts = @lifts.where('amount < 0').where(@sql).order(date_of_commissioned: :desc)

  end

  private

  def chart_data(lifts)

    {size: {height: 400, width: 600},
     name: (get_data lifts.group(:name).select(:name, :amount).sum(:amount)),
     type: (get_data lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount), LiftType)}
  end

  def get_data(data, *model)
    sum = data.map {|d| d[1]}.sum
    data.map {|data| format_data(data, sum, model)
      {value: data[1].abs, label: data[0]}}.to_json
  end

  def format_data(data, sum, model)
    proc = data[1] / sum * 100
    data[0] = model[0].find(data[0]).name unless model.empty?
    data[0] = data[0] + ' (' + proc.round(2).to_s + ' %) '
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
    @lifts = Lift.where('user_id = ? and lift_type_id <> -2', current_user.id)
  end

  def where_build(simple, sql)
    filed = simple[:filed]
    condition = simple[:condition]
    value = simple[:value]
    operator = simple[:operator]

    sql += case condition
             when /like/
               filed + ' ' + condition + " '%" + value + "%' " + add_oper(operator)
             else
               filed + ' ' + condition + " '" + value + "' " + add_oper(operator)
           end
    sql
  end

  def add_oper(operator)
    oper = ''
    oper += operator + ' ' unless operator.nil?
    oper + ' '
  end
end

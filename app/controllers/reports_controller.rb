class ReportsController < ApplicationController
  before_action :init
  protect_from_forgery except: :show

  def cards
    @lifts = @lifts.where(transaction_type: 'Płatność kartą')
    @chart_data = chart_data @lifts
    @lifts = @lifts.order(date_of_commissioned: :desc)
  end

  def all_operation
    session[:form_date] = params.require(:form_date).permit(:type, :start, :stop) if params.keys.include? 'form_date'
    session[:sql] = sql_build unless (params.keys & %w[simple product value]).empty?
    if params.keys.include? 'clear'
      session.delete(:sql)
      session.delete(:form_date)
    end
    @form_date = FormDate.new(session[:form_date])
    @sql = session[:sql]
    @lifts = @lifts.where('amount < 0').where(sql_date).where(@sql)
    @chart_data = chart_data @lifts
    @lifts = @lifts.order(date_of_commissioned: :desc)
  end

  private

  def sql_date
    case @form_date.type
      when 'commissioned'
        set_date
      ['date_of_commissioned between ? and ?', @form_date.start, @form_date.stop]
    when 'booking'
        set_date
      ['date_of_booking between ? and ?', @form_date.start, @form_date.stop]
    else
      []
    end
  end

  def set_date
    @form_date.start = '1900-01-01' if @form_date.start == ''
    @form_date.stop = Time.now.strftime("%Y-%m-%d") if @form_date.stop == ''
  end

  def chart_data(lifts)
    { size: { height: 400, width: 600 },
      name: (get_data lifts.group(:name).select(:name, :amount).sum(:amount)),
      type: (get_data lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount), LiftType) }
  end

  def get_data(data, *model)
    sum = data.map { |d| d[1] }.sum
    data.map do |data|
      format_data(data, sum, model)
      { value: data[1].abs, label: data[0] }
    end.to_json
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
    @form_date = FormDate.new
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

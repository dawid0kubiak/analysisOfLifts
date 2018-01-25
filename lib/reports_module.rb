module ReportsModule

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
    {
        name: (get_data lifts.group(:name).select(:name, :amount).sum(:amount)),
        type: (get_data lifts.group(:lift_type_id).select(:lift_type_id, :amount).sum(:amount), LiftType),
        line: get_line_data(lifts)
    }
  end

  def get_line_data(lifts)
    lifts.group('EXTRACT(month from date_of_commissioned)')
        .order('extract_month_from_date_of_commissioned asc')
        .sum(:amount).map do |lift|
      lift[1] = lift[1].abs
      lift
    end
  end

  def get_data(data, *model)
    sum = data.map {|d| d[1]}.sum
    data.map do |data|
      format_data(data, sum, model)
      [data[0], data[1].abs]
    end
  end

  def format_data(data, sum, model)
    proc = data[1] / sum * 100
    data[0] = model[0].find(data[0]).name unless model.empty?
    data[0] = data[0] + ' (' + proc.round(2).to_s + ' %) '
  end

  def where_build(simple)
    filed = simple[:filed]
    condition = simple[:condition]
    value = simple[:value]
    operator = simple[:operator]

    case condition
      when /like/
        filed + ' ' + condition + " '%" + value + "%' " + operator.to_s
      else
        filed + ' ' + condition + " '" + value + "' " + operator.to_s
    end
  end

  def sql_build
    case params[:type]
      when 'simple'
        params[:simple].map {|s| where_build s}.join(' ')
      when 'saved'
        LiftType.find(params[:product]).condition
      when 'advanced'
        params[:value]
      else
        ''
    end
  end
end

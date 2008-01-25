module MonthsHelper
  def month_name(month)
    @month_names = {}
    @month_names[month] ||= Time.local(2007,month,1).strftime("%B")
  end
end

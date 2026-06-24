module NotificationsHelper
  def display_time(datetime)
    if datetime.to_date == Date.current
      datetime.strftime("%H:%M")
    else
      datetime.strftime("%-m/%-d")
    end
  end
end

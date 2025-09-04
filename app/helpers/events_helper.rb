module EventsHelper
  def event_time_range(event)
    start_str = I18n.l(event.start_time, format: :event_long)
    if event.end_time
      end_str = if event.start_time.to_date == event.end_time.to_date
                  I18n.l(event.end_time, format: :event_short)
                else
                  I18n.l(event.end_time, format: :event_long)
                end
      "#{start_str} - #{end_str}"
    else
      start_str
    end
  end
end

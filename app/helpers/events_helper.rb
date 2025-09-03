module EventsHelper
  def event_time_range(event)
    start_str = event.start_time.strftime('%B %d, %Y %I:%M %p')
    if event.end_time
      end_str = if event.start_time.to_date == event.end_time.to_date
                  event.end_time.strftime('%I:%M %p')
                else
                  event.end_time.strftime('%B %d, %Y %I:%M %p')
                end
      "#{start_str} - #{end_str}"
    else
      start_str
    end
  end
end

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

  def google_calendar_url(event)
    start_time_utc = event.start_time.utc.strftime('%Y%m%dT%H%M%SZ')
    end_time_utc = (event.end_time || event.start_time).utc.strftime('%Y%m%dT%H%M%SZ')

    params = {
      action: 'TEMPLATE',
      text: event.name,
      details: event.description,
      location: event.location,
      dates: "#{start_time_utc}/#{end_time_utc}",
      ctz: 'UTC',
      sprop: root_url + "events/#{event.id}"
    }

    'https://www.google.com/calendar/render?' + params.to_query
  end
end

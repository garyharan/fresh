json.extract! event, :id, :user_id, :name, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)

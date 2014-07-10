json.array!(@events) do |event|
  json.extract! event, :id, :name, :date, :event_start, :event_end, :location, :organiser, :description
  json.url event_url(event, format: :json)
end

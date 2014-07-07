json.array!(@event_images) do |event_image|
  json.extract! event_image, :id, :description
  json.url event_image_url(event_image, format: :json)
end

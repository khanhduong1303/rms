json.array!(@bulletins) do |bulletin|
  json.extract! bulletin, :id, :title, :date, :content, :send_notify, :condo_id
  json.url bulletin_url(bulletin, format: :json)
end

json.array!(@tech_supports) do |tech_support|
  json.extract! tech_support, :id, :name, :address, :phone, :email
  json.url tech_support_url(tech_support, format: :json)
end

json.array!(@privileges) do |privilege|
  json.extract! privilege, :id, :location, :price, :name, :distance, :date_expiry, :phone, :date_time_detail, :description, :user_id, :image_path
  json.url privilege_url(privilege, format: :json)
end

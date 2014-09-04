json.array!(@courses) do |course|
  json.extract! course, :id, :name, :description, :instructor, :price, :phone, :email, :image_path, :more_info
  json.url course_url(course, format: :json)
end

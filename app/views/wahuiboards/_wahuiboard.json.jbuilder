json.extract! wahuiboard, :id, :image, :title, :description, :status, :created_at, :updated_at
json.url wahuiboard_url(wahuiboard, format: :json)
json.image url_for(wahuiboard.image)

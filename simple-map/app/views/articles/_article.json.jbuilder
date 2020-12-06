json.extract! article, :id, :title, :address, :latitude, :longitude, :created_at, :updated_at
json.url article_url(article, format: :json)

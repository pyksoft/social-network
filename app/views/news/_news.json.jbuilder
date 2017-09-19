json.extract! news, :id, :message, :photo, :likes, :profile_id, :created_at, :updated_at
json.url news_url(news, format: :json)

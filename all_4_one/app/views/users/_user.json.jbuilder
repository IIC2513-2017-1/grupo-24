json.extract! user, :id, :admin, :email, :password, :name, :last_name, :created_at, :updated_at
json.url user_url(user, format: :json)

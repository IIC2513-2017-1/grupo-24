json.extract! project, :id, :goal, :title, :description, :user_id, :category_id, :created_at, :updated_at
json.url project_url(project, format: :json)

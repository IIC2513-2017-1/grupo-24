# frozen_string_literal: true

json.user do
  json.id @user.id
  json.href api_v1_user_url(@user)
  json.email @user.email
  json.name @user.name
  json.last_name @user.last_name
  json.projects do
    json.array! @user.projects do |project|
      json.id project.id
      json.href api_v1_projects_url(project)
      json.description project.description
    end
  end
end

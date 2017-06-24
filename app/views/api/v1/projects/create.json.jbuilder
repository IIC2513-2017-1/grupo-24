# frozen_string_literal: true

json.project do
  json.id @project.id
  json.title @project.title
  json.goal @project.goal
  json.description @project.description
  json.rating @project.rating
  json.category @project.category.name
  json.url api_v1_project_url(@project)
  json.owner do
    json.email @project.user.email
    json.first_name @project.user.name
    json.last_name @project.user.last_name
    json.url api_v1_user_url(@project.user)
  end
end

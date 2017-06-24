# frozen_string_literal: true

json.user do
  json.id @user.id
  json.url api_v1_user_url(@user)
  json.email @user.email
  json.username @user.username
  json.name @user.name
  json.last_name @user.last_name
  json.projects do
    json.array! @user.projects do |project|
      json.id project.id
      json.title project.title
      json.url api_v1_project_url(project)
    end
  end
  json.donations do
    json.array! @user.donations.group_by(&:project) do |project, donations|
      json.total donations.sum(&:ammount)
      json.n_donations donations.size
      json.project project.title
      json.project_url api_v1_project_url(project)
    end
  end
end

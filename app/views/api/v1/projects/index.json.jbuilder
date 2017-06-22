# frozen_string_literal: true

json.projects do
  json.array! @projects do |project|
    json.id project.id
    json.title project.title
    json.url api_v1_projects_url(project)
    json.user do
      json.email project.user.email
      json.first_name project.user.name + " " + project.user.last_name
      json.url api_v1_user_url(project.user)
    end
  end
end

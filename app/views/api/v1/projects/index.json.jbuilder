# frozen_string_literal: true

json.projects do
  json.array! @projects do |project|
    if project.publish
      json.id project.id
      json.title project.title
      json.url api_v1_project_url(project)
      json.user do
        json.email project.user.email
        json.name project.user.name + " " + project.user.last_name
        json.url api_v1_user_url(project.user)
      end
    end
  end
end

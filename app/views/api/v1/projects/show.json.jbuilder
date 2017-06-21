# frozen_string_literal: true

json.project do
  json.id project.id
  json.title project.title
  json.goal project.goal
  json.description project.description
  json.user do
    json.email project.user.email
    json.first_name project.user.name
    json.last_name project.user.last_name
  end
end

# frozen_string_literal: true

if @project.user == @current_user
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
    end
    json.donations do
      json.array! @project.donations.group_by(&:user) do |user, donations|
        json.id donations.first.id
        json.n_donations donations.size
        json.total donations.sum(&:ammount)
        json.donator user.full_name
        json.donator_url api_v1_user_url(user)
      end
    end
  end
else
  json.title @project.title
  json.description 'Este proyecto no es tuyo, solo el dueño puede actualizarlo'
end

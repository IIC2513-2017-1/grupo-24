class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :grade, inclusion: {in: [0,1,2,3,4,5]}
  validates :grade, :project, :user, presence: true

  after_save :update_project

  def update_project
    rates = Rate.where(project_id: project.id)
    new_rating = (rates.sum(&:grade))/(rates.size)
    puts new_rating, '################################'
    project.update(rating: new_rating)
  end
end

class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, :description, :goal, presence: true

end

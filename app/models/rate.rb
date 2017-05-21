class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :grade, inclusion: {in: [0,1,2,3,4,5]}
  validates :grade, :project, :user, presence: true
end

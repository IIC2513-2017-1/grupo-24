class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :ammount, presence: true
end

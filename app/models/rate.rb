class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validate :grade, numericality: { less_than_or_equal_to: 5,
                                   gretear_than_or_equal_to: 0,
                                   only_integer: true }
end

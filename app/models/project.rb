class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_attached_file :image, styles: { original: {}}

  validates :title, :description, :goal, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end

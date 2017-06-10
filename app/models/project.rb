class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_attached_file :image, styles: { original: {}}
  has_many :donations, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  validates :title, :description, :goal, :end_date, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_uniqueness_of :title, scope: [:user]

  before_create :unachieved

  def unachieved
    self.achieve = false
  end
end

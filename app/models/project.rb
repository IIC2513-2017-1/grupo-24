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
  before_save :validate_vimeo, if: :video_url?

  def validate_vimeo
    video_vimeo_json = JSON.load(open('https://vimeo.com/api/oembed.json?url=' + video_url))
    self.vimeo_id = video_vimeo_json['video_id']
  rescue OpenURI::HTTPError
    throw(:abort)
  end

  def unachieved
    self.achieve = false
  end
end

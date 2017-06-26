class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_attached_file :image, styles: { original: {},
                                      cropped: { processors: [:cropper] } }
  has_many :donations, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  validates :title, :description, :goal, :end_date, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_uniqueness_of :title, scope: [:user]

  before_create :unachieved
  before_save :validate_vimeo, if: :video_url?

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def validate_vimeo
    video_vimeo_json = JSON.load(open('https://vimeo.com/api/oembed.json?url=' + video_url))
    self.vimeo_id = video_vimeo_json['video_id']
  rescue OpenURI::HTTPError
    throw(:abort)
  end

  def tweets  # Obtain from stackoverflow
    consumer_key = "Cxje1uG5v7y4p0ubcd1SqvHrG"
    consumer_secret = "B15uRpYvEQRbztqDpJWEg4c2cUkZcXwybpwDWeOQB7jk2PkBm9"
    # Consumer secret shouldn't be up there :(
    credentials = Base64.encode64("#{consumer_key}:#{consumer_secret}").gsub("\n", '')
    url = "https://api.twitter.com/oauth2/token"
    body = "grant_type=client_credentials"
    headers = {
      "Authorization" => "Basic #{credentials}",
      "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
    }
    r = HTTParty.post(url, body: body, headers: headers)
    bearer_token = JSON.parse(r.body)['access_token']
    puts self.title
    api_auth_header = {"Authorization" => "Bearer #{bearer_token}"}
    url = "https://api.twitter.com/1.1/search/tweets.json?q=#{self.hashtag.gsub('#', '%23').gsub(' ', '+')}&result_type=recent"
    puts url
    JSON.parse(HTTParty.get(url, headers: api_auth_header).body)
  rescue OpenURI::HTTPError
    [{status: 'Failed'}]
  end

  def unachieved
    self.achieve = false
  end
end

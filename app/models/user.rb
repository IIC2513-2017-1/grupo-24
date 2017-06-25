class User < ApplicationRecord
  # TODO: check nullifies
  has_many :projects, dependent: :destroy
  has_many :donations, dependent: :nullify
  has_many :donations, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :nullify

  has_secure_password
  has_attached_file :avatar, styles: { original: {},
                                       cropped: { processors: [:cropper] } }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :username, :email, presence: true, uniqueness: true
  validates :password, presence: {on: :create}, confirmation: true,
            allow_blank: true, length: { minimum: 4, maximum: 72 }

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def full_name
    return "#{name} #{last_name}" if name && last_name
    return "#{name}" if first_name
    return "#{last_name}" if last_name
    email
  end

  def generate_token_and_save
    loop do
      self.token = SecureRandom.hex(64)
      break if save
    end
  end

end

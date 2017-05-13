class User < ApplicationRecord

  has_many :projects, dependent: :destroy
  has_many :donations
  has_secure_password
  has_attached_file :avatar, styles: { original: {} }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :username, :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 4, maximum: 72 }

  def full_name
    return "#{name} #{last_name}" if name && last_name
    return "#{name}" if first_name
    return "#{last_name}" if last_name
    email
  end

end

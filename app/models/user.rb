class User < ApplicationRecord
  has_many :projects
#  has_many :donations, class_name: 'Project', foreign_key: 'project_id',
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :username, :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 4 }

  def full_name
    return "#{name} #{last_name}" if name && last_name
    return "#{name}" if first_name
    return "#{last_name}" if last_name
    email
  end

end
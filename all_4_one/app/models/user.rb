class User < ApplicationRecord
  has_many :projects
#  has_many :donations, class_name: 'Project', foreign_key: 'project_id',

end

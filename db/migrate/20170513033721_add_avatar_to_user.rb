class AddAvatarToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_udpated_at, :datetime
  end
end

class AddVimeoToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :vimeo_id, :string
    add_column :projects, :video_url, :string
  end
end

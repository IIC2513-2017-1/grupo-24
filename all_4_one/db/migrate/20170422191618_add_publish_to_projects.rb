class AddPublishToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :publish, :boolean
  end
end

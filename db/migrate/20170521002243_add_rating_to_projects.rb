class AddRatingToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :rating, :float, defaul: 0
  end
end

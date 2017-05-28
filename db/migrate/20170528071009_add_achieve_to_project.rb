class AddAchieveToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :achieve, :boolean, default: false
  end
end

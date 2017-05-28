class AddEndDateToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :end_date, :date, default: Date.today + 5
  end
end

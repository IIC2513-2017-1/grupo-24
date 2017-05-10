class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.float :ammount

      t.timestamps
    end
  end
end

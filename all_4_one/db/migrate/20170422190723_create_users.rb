class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.boolean :admin
      t.string :email
      t.string :password
      t.string :name
      t.string :last_name

      t.timestamps
    end
  end
end

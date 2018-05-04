class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :title
      t.string :phone
      t.string :city
      t.references :links , index: true

      t.timestamps
    end
  end
end

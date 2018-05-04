class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.text :url
      t.string :page_number

      t.timestamps
    end
  end
end

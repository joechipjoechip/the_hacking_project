class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :url
      t.integer :likes
      t.integer :shares

      t.timestamps
    end
  end
end

class CreateGossips < ActiveRecord::Migration[5.1]
  def change
    create_table :gossips do |t|
      t.integer :mousaillon_id
      t.text :body

      t.timestamps
    end
  end
end

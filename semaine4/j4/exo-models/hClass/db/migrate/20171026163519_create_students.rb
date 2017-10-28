class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.text :bio
      t.integer :teach_id

      t.timestamps
    end
  end
end

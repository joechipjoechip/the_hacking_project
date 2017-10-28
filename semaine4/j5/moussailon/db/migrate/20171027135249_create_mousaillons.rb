class CreateMousaillons < ActiveRecord::Migration[5.1]
  def change
    create_table :mousaillons do |t|
      t.string :username
      t.text :bio
      t.string :email

      t.timestamps
    end
  end
end

class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name, unique: true, null: false

      t.timestamps
    end
  end
end

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.integer :cuisine_id, null: false
      t.integer :category_id, null: false
      t.integer :author_id, null: false
      t.text :image

      t.timestamps
    end
  end
end

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.references :cuisine_id, null: true, foreign_key: true
      t.references :category_id, null: true, foreign_key: true
      t.references :author_id, null: true, foreign_key: true
      t.text :image

      t.timestamps
    end
  end
end

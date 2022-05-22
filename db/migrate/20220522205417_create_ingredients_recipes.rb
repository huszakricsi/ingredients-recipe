class CreateIngredientsRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients_recipes do |t|
      t.integer :recipe_id, null: false
      t.integer :ingredient_id, null: false

      t.timestamps
    end
  end
end

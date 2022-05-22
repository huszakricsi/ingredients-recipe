class CreateIngredientRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_recipes do |t|
      t.references :recipe_id, null: false, foreign_key: true
      t.references :ingredient_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddIngredientCountToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :ingredients_count, :integer
  end
end

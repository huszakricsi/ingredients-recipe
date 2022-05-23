class IngredientRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  after_save :recalculate_ingredients

  validates_uniqueness_of :recipe_id, scope: :ingredient_id

  private

  def recalculate_ingredients
    recipe.update(ingredients_count: recipe.ingredient_recipes.count)
  end
end

module RecipesHelper
  def ingredients_list(recipe)
    recipe.ingredients.inject("") do |result, ingredient|
      result + content_tag(:li, ingredient.name)
    end.html_safe
  end

  def ingredients_list_with_commas(recipe)
    recipe.ingredients.pluck(:name).join(', ')
  end
end

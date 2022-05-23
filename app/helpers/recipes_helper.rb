module RecipesHelper
  def order_links_for(attribute, external_attribute_field = nil)
    if external_attribute_field.blank?
      link_to('^', recipes_path(filter_params.merge(order_param: "#{attribute} ASC"))) +
      link_to('ˇ', recipes_path(filter_params.merge(order_param: "#{attribute} DESC")))
    else
      link_to('^', recipes_path(filter_params.merge(order_param: "#{attribute}.#{external_attribute_field} ASC"))) +
      link_to('ˇ', recipes_path(filter_params.merge(order_param: "#{attribute}.#{external_attribute_field} DESC")))
    end
  end

  def ingredients_list(recipe)
    recipe.ingredients.inject("") do |result, ingredient|
      result + content_tag(:li, ingredient.name)
    end.html_safe
  end

  def ingredients_list_with_commas(recipe)
    recipe.ingredients.pluck(:name).join(', ')
  end

  def filter_params
    @filter_params = params.permit(:ingredients, :page_param, author_ids: [], category_ids: [], cuisine_ids: [])
  end
end

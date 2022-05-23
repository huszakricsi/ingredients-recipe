class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.includes(:author, :category, :cuisine)

    @recipes = @recipes.ingredients_search(ingredient_names) if ingredient_names.present?
    @recipes = @recipes.author_search(author_ids)            if author_ids.present?
    @recipes = @recipes.category_search(category_ids)        if category_ids.present?
    @recipes = @recipes.cuisine_search(cuisine_ids)          if cuisine_ids.present?
    
    @recipes = @recipes.order(order_param).page(page_param).per(::Configuration.instance.paginates_per)
  end

  def show
    @recipe = Recipe.find(id_param)
  end

  private

  def ingredient_names
    if (ingredient_names = params.permit(:ingredients)[:ingredients]) && ((ingredient_names = ingredient_names.split(",").map(&:strip).compact_blank).length > 0)
      ingredient_names
    end
  end

  def author_ids
    params.permit(author_ids: [])[:author_ids].try(:compact_blank)
  end

  def category_ids
    params.permit(category_ids: [])[:category_ids].try(:compact_blank)
  end

  def cuisine_ids
    params.permit(cuisine_ids: [])[:cuisine_ids].try(:compact_blank)
  end

  def id_param
    params.permit(:id)[:id]
  end

  def order_param
    params.permit(:order_param)[:order_param]
  end
  
  def page_param
    params.permit(:page)[:page]
  end

end

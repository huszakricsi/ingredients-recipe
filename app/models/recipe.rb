class Recipe < ApplicationRecord
  has_many :ingredient_recipes
  has_many :ingredients, :through => :ingredient_recipes
  belongs_to :cuisine, optional: true
  belongs_to :category, optional: true
  belongs_to :author, optional: true

  validates :title, presence: true
  validates :image, image_url: true
 
  scope :author_search, ->(author_ids) { where(author_id: author_ids) }

  scope :category_search, ->(category_ids) { where(category_id: category_ids) }

  scope :cuisine_search, ->(cuisine_ids) { where(cuisine_id: cuisine_ids) }

  scope :ingredients_search, ->(ingredient_names) {
    where(id: IngredientRecipe.joins(:ingredient, :recipe)
                              .where("ingredients.name ILIKE ANY ( array[?] )", ingredient_names.map{|i| "%#{i}%"})
                              .group(:recipe_id, 'recipes.ingredients_count')
                              .having('COUNT(*) = recipes.ingredients_count')
                              .select(:recipe_id)
          )
  }

end

class Recipe < ApplicationRecord
  has_many :ingredient_recipes
  has_many :ingredients, :through => :ingredient_recipes
  belongs_to :cuisine, optional: true
  belongs_to :category, optional: true
  belongs_to :author, optional: true
end

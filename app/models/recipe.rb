class Recipe < ApplicationRecord
  has_and_belongs_to_many :ingredients
  belongs_to :cuisine
  belongs_to :category
  belongs_to :author
end

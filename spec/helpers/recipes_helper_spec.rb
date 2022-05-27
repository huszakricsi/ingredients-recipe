require 'rails_helper'

RSpec.describe RecipesHelper, type: :helper do
  describe 'ingredients_list methods' do
    let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
    let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
    let(:ingredient_3) { Ingredient.create(name: 'ingredient_3') }
    
    let(:recipe)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_1, ingredient_2, ingredient_3]) }
    
    let(:expected_ingredients_list)             {'<li>ingredient_1</li><li>ingredient_2</li><li>ingredient_3</li>'}
    let(:expected_ingredients_list_with_commas) {'ingredient_1, ingredient_2, ingredient_3'}

    it 'ingredients_list returns the list of ingredients using ListItems' do
      expect(ingredients_list(recipe)).to eq(expected_ingredients_list)
    end

    it 'ingredients_list_with_commas returns the list of ingredients using ListItems' do
      expect(ingredients_list_with_commas(recipe)).to eq(expected_ingredients_list_with_commas)
    end
  end
end

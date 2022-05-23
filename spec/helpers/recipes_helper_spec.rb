require 'rails_helper'

RSpec.describe RecipesHelper, type: :helper do
  describe 'order_links_for' do
    let(:expected_order_links_for_class_attributes)    {"<a href=\"/recipes?author_ids%5B%5D=1&amp;author_ids%5B%5D=2&amp;author_ids%5B%5D=3&amp;category_ids%5B%5D=4&amp;category_ids%5B%5D=5&amp;category_ids%5B%5D=6&amp;cuisine_ids%5B%5D=7&amp;cuisine_ids%5B%5D=8&amp;cuisine_ids%5B%5D=9&amp;ingredients=a%2Cb%2Cc&amp;order_param=ratings+ASC&amp;page_param=12\">^</a><a href=\"/recipes?author_ids%5B%5D=1&amp;author_ids%5B%5D=2&amp;author_ids%5B%5D=3&amp;category_ids%5B%5D=4&amp;category_ids%5B%5D=5&amp;category_ids%5B%5D=6&amp;cuisine_ids%5B%5D=7&amp;cuisine_ids%5B%5D=8&amp;cuisine_ids%5B%5D=9&amp;ingredients=a%2Cb%2Cc&amp;order_param=ratings+DESC&amp;page_param=12\">ˇ</a>"}
    let(:expected_order_links_for_external_attributes) {"<a href=\"/recipes?author_ids%5B%5D=1&amp;author_ids%5B%5D=2&amp;author_ids%5B%5D=3&amp;category_ids%5B%5D=4&amp;category_ids%5B%5D=5&amp;category_ids%5B%5D=6&amp;cuisine_ids%5B%5D=7&amp;cuisine_ids%5B%5D=8&amp;cuisine_ids%5B%5D=9&amp;ingredients=a%2Cb%2Cc&amp;order_param=authors.name+ASC&amp;page_param=12\">^</a><a href=\"/recipes?author_ids%5B%5D=1&amp;author_ids%5B%5D=2&amp;author_ids%5B%5D=3&amp;category_ids%5B%5D=4&amp;category_ids%5B%5D=5&amp;category_ids%5B%5D=6&amp;cuisine_ids%5B%5D=7&amp;cuisine_ids%5B%5D=8&amp;cuisine_ids%5B%5D=9&amp;ingredients=a%2Cb%2Cc&amp;order_param=authors.name+DESC&amp;page_param=12\">ˇ</a>"}
    let(:params) { {ingredients: "a,b,c", page_param: 12, author_ids: [1,2,3], category_ids: [4,5,6], cuisine_ids: [7,8,9]} }
    
    before :each do
      expect_any_instance_of(RecipesHelper).to receive(:filter_params).exactly(2).times.and_return(params)
    end
    
    it 'Creates order links for class attributes while keeping the params' do
      expect(order_links_for('authors', 'name')).to eq(expected_order_links_for_external_attributes)
    end
    it 'Creates order links for associated attributes while keeping the params' do
      expect(order_links_for('ratings')).to eq(expected_order_links_for_class_attributes)
    end
  end

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

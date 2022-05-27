require 'rails_helper'

RSpec.describe Recipe, type: :model do

  describe 'DB columns, constraints and relations', :shoulda do
    it { should have_db_column(:id)               .of_type(:integer)               }
    it { should have_db_column(:created_at)       .of_type(:datetime)              }
    it { should have_db_column(:updated_at)       .of_type(:datetime)              }
    it { should have_db_column(:author_id)        .of_type(:integer)               }
    it { should have_db_column(:category_id)      .of_type(:integer)               }
    it { should have_db_column(:cuisine_id)       .of_type(:integer)               }
    it { should have_db_column(:ingredients_count).of_type(:integer)               }
    it { should have_db_column(:title)            .of_type(:string)                }

    
    it { should have_many(:ingredient_recipes)                        }
    it { should have_many(:ingredients).through('ingredient_recipes') }
  end

  include_examples "property presences", ["title"]

  describe 'Validations' do
    let(:valid_image_create_params)   { { image: 'http://www.image.com/image/123' } }
    let(:invalid_image_create_params) { { image: 'not an url'} }

    
    it "Pass the validation if the image is an URL" do
      expect(described_class.create(valid_image_create_params).errors.full_messages).not_to include('Image is not a valid HTTP URL')
    end
    it "Pass the validation if the image is not an URL" do
      expect(described_class.create(invalid_image_create_params).errors.full_messages).to   include('Image is not a valid HTTP URL')
    end
  end
 
  describe 'Scopes' do
    describe 'author_search' do
      let(:author_1)        { Author.create(name: 'author_1') }
      let(:author_2)        { Author.create(name: 'author_2') }
      let(:author_3)        { Author.create(name: 'author_3') }

      let!(:recipe_1)        { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', author: author_1) }
      let!(:recipe_2)        { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', author: author_2) }
      let!(:recipe_3)        { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', author: author_3) }

      let(:search_criteria) { [author_1, author_2].pluck(:id) }
      let(:expected_result) { [recipe_1, recipe_2].pluck(:id) }

      it 'Filters correctly by author' do
        expect(Recipe.author_search(search_criteria).pluck(:id)).to match_array(expected_result)
      end
    end

    describe 'category_search' do
      let(:category_1)     { Category.create(name: 'category_1') }
      let(:category_2)     { Category.create(name: 'category_2') }
      let(:category_3)     { Category.create(name: 'category_3') }

      let!(:recipe_1)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', category: category_1) }
      let!(:recipe_2)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', category: category_2) }
      let!(:recipe_3)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', category: category_3) }

      let(:search_criteria) { [category_1, category_2].pluck(:id) }
      let(:expected_result) { [recipe_1, recipe_2].pluck(:id) }

      it 'Filters correctly by category' do
        expect(Recipe.category_search(search_criteria).pluck(:id)).to match_array(expected_result)
      end
    end

    describe 'cuisine_search' do
      let(:cuisine_1)      { Cuisine.create(name: 'cuisinea') }
      let(:cuisine_2)      { Cuisine.create(name: 'cuisineb') }
      let(:cuisine_3)      { Cuisine.create(name: 'cuisinec') }

      let!(:recipe_1)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', cuisine: cuisine_1) }
      let!(:recipe_2)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', cuisine: cuisine_2) }
      let!(:recipe_3)       { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', cuisine: cuisine_3) }

      let(:search_criteria) { [cuisine_1, cuisine_2].pluck(:id) }
      let(:expected_result) { [recipe_1, recipe_2].pluck(:id) }

      it 'Filters correctly by cusine' do
        expect(Recipe.cuisine_search(search_criteria).pluck(:id)).to match_array(expected_result)
      end
    end

    describe 'all_ingredients_owned_search' do
      let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
      let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
      let(:ingredient_3) { Ingredient.create(name: 'ingredient_3') }

      let!(:recipe_1)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_1]) }
      let!(:recipe_2)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_2, ingredient_3]) }
      let!(:recipe_3)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_3]) }

      let(:search_criteria_1) { ['ingredient_2', 'ingredient_3'] }
      let(:expected_result_1) { [recipe_2, recipe_3].pluck(:id) }

      let(:search_criteria_2) { ['ingredient_1', 'ingredient_3'] }
      let(:expected_result_2) { [recipe_1, recipe_3].pluck(:id) }

      it 'Filters correctly by ingredients' do
        expect(Recipe.all_ingredients_owned_search(search_criteria_1).pluck(:id)).to match_array(expected_result_1)
        expect(Recipe.all_ingredients_owned_search(search_criteria_2).pluck(:id)).to match_array(expected_result_2)
      end
    end

    describe 'most_relevant_ingredients_search' do
      let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
      let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
      let(:ingredient_3) { Ingredient.create(name: 'ingredient_3') }

      let!(:recipe_1)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_1]) }
      let!(:recipe_2)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_2, ingredient_3]) }
      let!(:recipe_3)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_3]) }

      let(:search_criteria_1) { ['ingredient_2', 'ingredient_3'] }
      let(:expected_result_1) { [recipe_2, recipe_3].pluck(:id) }

      let(:search_criteria_2) { ['ingredient_1', 'ingredient_3'] }
      let(:expected_result_2) { [recipe_1, recipe_2, recipe_3].pluck(:id) }

      it 'Filters correctly by ingredients' do
        expect(Recipe.most_relevant_ingredients_search(search_criteria_1).map(&:id)).to match_array(expected_result_1)
        expect(Recipe.most_relevant_ingredients_search(search_criteria_2).map(&:id)).to match_array(expected_result_2)
      end
    end

    describe 'All the scopes chained' do
      let(:author_1)     { Author.create(name: 'author_1') }
      let(:author_2)     { Author.create(name: 'author_2') }
      let(:author_3)     { Author.create(name: 'author_3') }

      let(:category_1)   { Category.create(name: 'category_1') }
      let(:category_2)   { Category.create(name: 'category_2') }
      let(:category_3)   { Category.create(name: 'category_3') }

      let(:cuisine_1)    { Cuisine.create(name: 'cuisinea') }
      let(:cuisine_2)    { Cuisine.create(name: 'cuisineb') }
      let(:cuisine_3)    { Cuisine.create(name: 'cuisinec') }

      let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
      let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
      let(:ingredient_3) { Ingredient.create(name: 'ingredient_3') }

      let!(:recipe_1)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', author: author_1, category: category_1, cuisine: cuisine_1, ingredients: [ingredient_1]) }
      let!(:recipe_2)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', author: author_2, category: category_2, cuisine: cuisine_2, ingredients: [ingredient_2, ingredient_3]) }
      let!(:recipe_3)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', author: author_3, category: category_3, cuisine: cuisine_3, ingredients: [ingredient_3]) }

      let(:search_criteria_by_authors) { [author_1, author_2].pluck(:id) }
      let(:search_criteria_by_categories) { [category_2, category_3].pluck(:id) }
      let(:search_criteria_by_cuisines) { [cuisine_1, cuisine_2, cuisine_3].pluck(:id) }
      let(:search_criteria_by_ingredients) { ['ingredient_2', 'ingredient_3'] }

      let(:expected_result_1) { [recipe_2].pluck(:id) }
      it 'Filters correctly by both author, category, cusine and ingredients' do
        expect(Recipe
                .author_search(search_criteria_by_authors)
                .category_search(search_criteria_by_categories)
                .cuisine_search(search_criteria_by_cuisines)
                .all_ingredients_owned_search(search_criteria_by_ingredients)
                .pluck(:id)
              ).to match_array(expected_result_1)
      end
    end
  end

end

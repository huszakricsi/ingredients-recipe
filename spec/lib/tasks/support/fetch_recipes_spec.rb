require 'rails_helper'

RSpec.describe 'support:fetch_recipes', type: :task do
  include_context 'stdout'
  include_context 'stub recipe request'
  let(:image) { "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg" }
  let(:ingredient_names) { ["1 cup all-purpose flour", "1 cup yellow cornmeal", "⅔ cup white sugar", "1 teaspoon salt", "3 ½ teaspoons baking powder", "1 egg", "1 cup milk", "⅓ cup vegetable oil"] }
  let(:title) { "Golden Sweet Cornbread" }
  let(:author_name) { "bluegirl" }
  let(:category_name) { "Cornbread" }
  let(:cuisine_name) { "cuisine" }
  let(:recipe_objects) { [{"title"=> title, "cook_time"=>25, "prep_time"=>10, "ingredients"=> ingredient_names, "ratings"=>4.74, "cuisine"=> cuisine_name, "category"=> category_name, "author"=> author_name, "image"=> image}] }
  let(:expected_output) {  ["\"Create temporary directory for the recipes\"", "\"Fetching the recipes\"", "\"Decompressing and parsing\"", "\"Storing the recipes and associations\"", "\"1/1\"", "\"Temporary directory deleted\"", "\"Recipe fetch finished\""] }

  around :each do |example|
    IngredientsRecipe::Application.load_tasks
    begin
      example.run
    ensure
      Rake::Task.clear
    end
  end

  describe "It works correctly" do 
    it 'Fetches the recipes and stores it' do

      Rake::Task['support:fetch_recipes'].invoke

      stdout.rewind
      lines = stdout.string.split("\n")

      expect(lines).to eq(expected_output)

      expect(Author.count).to     eq(1)
      expect(Category.count).to   eq(1)
      expect(Cuisine.count).to    eq(1)
      expect(Recipe.count).to     eq(1)
      expect(Ingredient.count).to eq(8)

      recipe = Recipe.first

      expect(recipe.author.name)  .to eq(author_name)
      expect(recipe.category.name).to eq(category_name)
      expect(recipe.cuisine.name) .to eq(cuisine_name)
  
      expect(recipe.ingredients.pluck(:name)).to eq(ingredient_names)
    end
  end
end

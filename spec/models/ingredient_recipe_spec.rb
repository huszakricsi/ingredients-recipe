require 'rails_helper'

RSpec.describe IngredientRecipe, type: :model do  
  describe 'DB columns, constraints and relations', :shoulda do
    it { should have_db_column(:id)        .of_type(:integer)                           }
    it { should have_db_column(:created_at).of_type(:datetime)                          }
    it { should have_db_column(:updated_at).of_type(:datetime)                          }

    it { should belong_to(:recipe).class_name('Recipe') }
    it { should belong_to(:ingredient).class_name('Ingredient') }
  end

  describe 'Validations' do
    let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
    let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
    let(:recipe_1)     { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_1]) }
    it "Pass the validation if the recipe and ingredient pairs are uniq, but if not it fails" do
      expect(IngredientRecipe.create(ingredient: ingredient_2, recipe: recipe_1).errors.full_messages).to be_blank
      expect(IngredientRecipe.create(ingredient: ingredient_2, recipe: recipe_1).errors.full_messages).to include('Recipe has already been taken')
    end
  end

  describe "Callbacks" do
    let(:ingredient_1)        { Ingredient.create(name: 'ingredient_1') }
    let(:recipe_1)            { Recipe.create(title: 'title', image: 'http://www.image.com/image/123') }
    let(:ingredient_recipe_1) { IngredientRecipe.new }
    it "Recalculates ingredients_count after_save" do
      expect(recipe_1.ingredients_count).to eq(nil)
      ingredient_recipe_1.update(ingredient: ingredient_1, recipe: recipe_1)
      expect(recipe_1.ingredients_count).to eq(1)
    end

    it "Calls recalculate_ingredients after_save" do
      expect(ingredient_recipe_1).to receive(:recalculate_ingredients)
      ingredient_recipe_1.update(ingredient: ingredient_1, recipe: recipe_1)
    end
  end

end

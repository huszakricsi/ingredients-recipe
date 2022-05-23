require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
    let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
    let(:ingredient_3) { Ingredient.create(name: 'ingredient_3') }

    let!(:recipe_1)     { Recipe.create(title: 'title1', image: 'http://www.image.com/image/123', ingredients: [ingredient_1]) }
    let!(:recipe_2)     { Recipe.create(title: 'title2', image: 'http://www.image.com/image/123', ingredients: [ingredient_2, ingredient_3]) }
    let!(:recipe_3)     { Recipe.create(title: 'title3', image: 'http://www.image.com/image/123', ingredients: [ingredient_3]) }

    it "returns http success" do
      get "/recipes", :params => { ingredients: "ingredient_2, ingredient_3" }
      expect(response).to have_http_status(:success)
    end

    it "page only contains the filtered recipes" do
      get "/recipes", :params => { ingredients: "ingredient_2, ingredient_3" }

      expect(response.body).not_to include("title1")
      expect(response.body).to     include("title2")
      expect(response.body).to     include("title3")
    end
  end

  describe "GET /show" do
    let(:ingredient_1) { Ingredient.create(name: 'ingredient_1') }
    let(:ingredient_2) { Ingredient.create(name: 'ingredient_2') }
    let(:ingredient_3) { Ingredient.create(name: 'ingredient_3') }

    let(:recipe)      { Recipe.create(title: 'title', image: 'http://www.image.com/image/123', ingredients: [ingredient_1, ingredient_2, ingredient_3]) }

    it "returns http success" do
      get "/recipe/#{recipe.id}"
      expect(response).to have_http_status(:success)
    end
    
    it "page contains all ingredients" do
      get "/recipe/#{recipe.id}"

      expect(response.body).to include("ingredient_1")
      expect(response.body).to include("ingredient_2")
      expect(response.body).to include("ingredient_3")
    end
  end

end


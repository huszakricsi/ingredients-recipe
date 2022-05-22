namespace :support do
  desc "Fetch recipes"
  task fetch_recipes: :environment do

    p 'Create temporary directory for the recipes'
    Dir.mktmpdir('tmp_dir_for_recipes') do |dir|

      p 'Fetching the recipes'
      url      = ::Configuration.instance.recipes_url
      request  = RestClient::Request.new(method: :get, headers: { content_type: 'application/gzip'}, url: url)
      response = request.execute.body

      p 'Decompressing and parsing'
      decompressed    = ActiveSupport::Gzip.decompress(response)
      parsed_recipes  = JSON.parse(decompressed)

      p 'Storing the recipes and associations'
      parsed_recipes.each_with_index do |recipe, index|

        recipe['author_id']   = Author.find_or_create_by!({name: recipe['author']}).id     if recipe['author'].present?
        recipe['category_id'] = Category.find_or_create_by!({name: recipe['category']}).id if recipe['category'].present?
        recipe['cuisine_id']  = Cuisine.find_or_create_by!({name: recipe['cuisine']}).id   if recipe['cuisine'].present?

        recipe['ingredient_ids'] = recipe['ingredients'].map do |ingredient|
          Ingredient.find_or_create_by!(name: ingredient).id
        end

        recipe.except!('author', 'category', 'cuisine', 'ingredients')

        Recipe.create(recipe)

        p "#{parsed_recipes.count}/#{index+1}"
      end
      p 'Temporary directory deleted'
      p 'Recipe fetch finished'
    end
  end
end

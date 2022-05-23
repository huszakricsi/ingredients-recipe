Rails.application.routes.draw do
  get '/', to: redirect('/recipes')

  get 'recipes',     to: 'recipes#index', as: :recipes
  get 'recipe/:id',  to: 'recipes#show',  as: :recipe
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

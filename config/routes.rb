Rails.application.routes.draw do
  root to: redirect("/recipes/new")
  resources :recipes, only: [:show, :new, :create]
end

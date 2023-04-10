Rails.application.routes.draw do
  root to: redirect("/recipes")
  resources :recipes, only: [:index, :show, :new, :create]
end

Foodz::Application.routes.draw do
  namespace :hubot do
    resources :orders, :food
  end
end

Foodz::Application.routes.draw do
  namespace :hubot do
    resources :orders do
      post 'mail', on: :collection
    end
    resources :food
  end

  # config/routes.rb
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end
end

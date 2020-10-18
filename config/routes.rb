Rails.application.routes.draw do
  resources :hospitals do
    resources :doctors
  end
end

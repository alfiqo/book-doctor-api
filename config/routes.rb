Rails.application.routes.draw do
  resources :hospitals do
    resources :doctors
  end
  post "auth/login", to: "authentication#authenticate"
end

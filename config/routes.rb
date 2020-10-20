Rails.application.routes.draw do
  resources :hospitals do
    resources :doctors do
      resources :schedules
      resources :appointments
    end
  end
  post "auth/login", to: "authentication#authenticate"
  post "signup", to: "users#create"
  
end

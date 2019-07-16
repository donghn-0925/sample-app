Rails.application.routes.draw do
  root "static_pages#home"

  resources :static_pages do
    collection do
      get :help, :home, :about, :contact
    end
  end
  get "/signup", to: "users#new"
end

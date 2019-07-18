Rails.application.routes.draw do
  root "application#hello"

  resources :static_pages do
    collection do
      get :help, :home, :about
    end
  end
end

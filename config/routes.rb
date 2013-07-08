ApiSemenets::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  
  namespace 'admin' do
    resources :pages do
      collection do
        get :published
        get :unpublished
      end
      member do
        get :publish
        get :total_words
      end
    end
  end

  namespace 'content_provider' do
    resources :pages do
      collection do
        get :published
        get :unpublished
      end
      member do
        get :total_words
      end
    end
  end

  root to: "sessions#new"
end

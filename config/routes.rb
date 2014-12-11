Rails.application.routes.draw do
  root 'welcome#index'
  get 'faq', to: 'welcome#faq'

  resources :listings, except: [:index, :update], path: 'l' do
    member do
      patch 'edit', to: 'listings#update', as: 'update'

      scope 'transaction' do
        get 'new', to: 'transaction#new', as: 'new_transaction'
        get ':label', to: 'transaction#show', as: 'transaction'
      end
    end
  end

  post "l/cover_upload", to: 'listings#cover_upload', as: :cover_upload

end

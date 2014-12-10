Rails.application.routes.draw do
  root 'welcome#index'
  get 'faq', to: 'welcome#faq'

  resources :listings, except: [:index, :create, :update], path: 'l' do
    member do
      patch 'edit', to: 'listings#update', as: 'update'

      scope 'transaction' do
        get 'new', to: 'transaction#new', as: 'new_transaction'
        get ':label', to: 'transaction#show', as: 'transaction'
      end
    end
  end
end

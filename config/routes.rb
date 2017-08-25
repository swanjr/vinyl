# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  resources :records, except: [:create]

  namespace 'api', defaults: {:format => :json}  do
    namespace 'v1' do 
      resources :records, only: [:create]
    end
  end

  get '/', to: 'records#index'
end


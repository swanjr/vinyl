# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  namespace 'api', :defaults => {:format => :json}  do
    namespace 'v1' do 
      resources :records, except: [:show, :edit, :new]
    end
  end

  get '/', to: 'app_loader#show'
end


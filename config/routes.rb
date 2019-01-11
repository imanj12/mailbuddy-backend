Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'auth/request', to:'authorization#get_authorization'

  namespace :api, defaults: {format: :json} do 
    namespace :v1 do 
      post '/imap', to: 'imap#establishConnection'
      post '/pop', to: 'pop#initiateDownload'
      post '/gapi', to: 'gapi#fetchData'
    end
  end

end

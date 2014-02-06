OpentokTest::Application.routes.draw do
  
  root :to => "rooms#index"
  
  resources :rooms
   
  match "/party/:id", :to => "rooms#party", :as => :party, :via => :get

end

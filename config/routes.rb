Whois::Application.routes.draw do
	
  root :to => "domains#new"
	
	match "domains/new" => "domains#new", :as => :search_domain
	match "domains/create" => "domains#create", :as => :create_domain
	match "domains/:zone/*domain" => "domains#show"
	
 
end

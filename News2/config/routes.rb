require 'api_constraints'

  Rails.application.routes.draw do
    namespace :api, defaults: {format: 'json'} do
      scope module: :v1, constraints: ApiConstraints.new(version: 1,  default: true) do
        resources :news

        match "news/search" => "news#search", :via => :post
        match "news/autocomplete" => "news#autocomplete", :via => :get
        match "news/num/:id" => "news#num", :via => :get
      end
  end

end

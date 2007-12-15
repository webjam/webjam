ActionController::Routing::Routes.draw do |map|
  map.resources :posts do |posts|
    posts.resources :comments, :name_prefix => 'post_'
  end
  map.resources :comments
  
  map.resources :events, :collection => [:past]

  map.resource :session, :member => { :create => :any }

  map.resource :user, :name_prefix => 'current_', :member => {:update_privacy => :put, :update_profile_details => :put}
  map.resources :users, :collection => {:verify => :any, :details => :get, :create => :post}

  map.resource :mugshot, :name_prefix => 'current_'
  map.resources :mugshots, :member => {:crop => :any}

  map.resources :identity_urls, :collection => {:create => :any}

  map.with_options(:controller => 'home') do |m|
    m.about 'about', :action => 'about'
    m.contact 'contact', :action => 'contact'
    m.home '', :action => 'index'
  end
  
  map.namespace :admin do |admin|
    admin.resources :locations, :events, :posts
  end
  map.admin 'admin', :controller => 'admin/home'
end

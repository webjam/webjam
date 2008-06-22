ActionController::Routing::Routes.draw do |map|
  map.resources :posts do |posts|
    posts.resources :comments, :name_prefix => 'post_'
  end
  map.resources :comments
  map.resource  :session, :member => { :create => :any }

  map.event ":id", :controller => "events", :action => "show", :requirements => {:id => /webjam\d+/}
  map.event_rsvps ":event/rsvps", :controller => "rsvps", :action => "create", :conditions => { :method => :post }, :requirements => {:event => /webjam\d+/}
  map.event_proposals ":event/proposals", :controller => "proposals", :action => "create", :conditions => { :method => :post }, :requirements => {:event => /webjam\d+/}
  
  map.with_options(:controller => "users") do |user|
    user.update_profile_details_current_user 'account/update_profile_details', :conditions => {:method => :put}, :action => "update_profile_details"
    user.update_privacy_current_user 'account/update_privacy', :conditions => {:method => :put}, :action => "update_profile_details"
    user.edit_current_user 'account', :conditions => {:method => :get}, :action => "edit"
  end  
  map.resources :users, :collection => {:verify => :any, :details => :get, :create => :post}
  
  map.resource  :mugshot, :name_prefix => 'current_'
  map.resources :mugshots, :member => {:crop => :any}

  map.resources :identity_urls, :collection => {:create => :any}
  map.with_options(:controller => 'pages') do |m|
    m.about   'about',   :action => 'about'
    m.contact 'contact', :action => 'contact'
    m.home    '',        :action => 'home'
    m.open_id   'single-sign-on',   :action => 'single-sign-on'
  end
  map.namespace :admin do |admin|
    admin.resources :events do |event|
      event.resources :rsvps
    end
    admin.resources :locations, :posts
  end
  map.admin 'admin', :controller => 'admin/home'
  map.legacy_post 'post/:permalink.html', :controller => "posts", :action => "legacy" 
  map.user '*path_info', :controller => 'users', :action => 'show'
end

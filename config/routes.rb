ActionController::Routing::Routes.draw do |map|
  EVENT_TAG = /webjam\d+/

  # super friendly post urls
  map.posts 'news', :controller => 'posts', :action => 'index'
  map.posts_year 'news/:year', 
                :controller => 'posts', 
                :action => 'index_by_year',
                :year => /\d{4}/
  map.post 'news/:year/:permalink',
                :controller => 'posts',
                :action => 'show',
                :year => /\d{4}/
  map.post_comments 'news/:year/:permalink/comments',
                :controller => 'comments',
                :action => 'create',
                :year => /\d{4}/,
                :conditions => { :method => :post }

  map.resources :comments
  map.resource  :session, :member => { :create => :any }

  map.event ":id", :controller => "events", :action => "show", :requirements => {:id => EVENT_TAG}
  map.event_rsvps ":event_id/rsvps", :controller => "rsvps", :action => "create", :conditions => { :method => :post }, :requirements => {:event_id => EVENT_TAG}
  map.event_rsvp ":event_id/rsvps/:id", :controller => "rsvps", :action => "destroy", :conditions => { :method => :delete }, :requirements => {:event_id => EVENT_TAG}
  
  map.with_options(:controller => "presentation_proposals", :requirements => {:event_id => EVENT_TAG}) do |proposals|
    proposals.event_presentation_proposal ":event_id/proposal", :action => "edit", :conditions => { :method => :get }
    proposals.event_presentation_proposal ":event_id/proposal", :action => "update", :conditions => { :method => :post }
    proposals.event_presentation_proposal ":event_id/proposal", :action => "destroy", :conditions => { :method => :delete }
  end
  
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
    m.contact 'contact', :action => 'contact'
    m.home    '',        :action => 'home'
    m.open_id   'single-sign-on',   :action => 'single-sign-on'
    m.vote_vis 'votestream', :action => "votestream"
    # temporary static files to build front-end
    m.statichome   'statichome',   :action => 'statichome'
    m.staticevent   'staticevent',   :action => 'staticevent'
    m.staticpostevent   'staticpostevent',   :action => 'staticpostevent'
  end
  map.namespace :admin do |admin|
    admin.resources :events do |event|
      event.resources :rsvps
    end
    admin.resources :posts
  end
  map.admin 'admin', :controller => 'admin/home'
  map.legacy_post 'post/:permalink.html', :controller => "posts", :action => "legacy" 
  map.user '*path_info', :controller => 'users', :action => 'show'
end

ActionController::Routing::Routes.draw do |map|
  EVENT_TAG = /webjam\d+/

  # super friendly post urls
  map.with_options(:controller => "posts") do |posts|
    posts.posts           'news', :action => 'index'
    posts.formatted_posts 'news.:format', :action => 'index'
    posts.posts_year      'news/:year',  :action => 'index_by_year', :year => /\d{4}/
    posts.with_options(:action => 'show', :year => /\d{4}/) do |post|
      post.post           'news/:year/:permalink'
      post.formatted_post 'news/:year/:permalink.:format'
    end
  end
  map.post_comments 'news/:year/:permalink/comments',
                :controller => 'comments',
                :action => 'create',
                :year => /\d{4}/,
                :conditions => { :method => :post }

  map.resources :comments
  map.resource  :session, :member => { :create => :any }

  map.with_options(:controller => "events") do |events|
    events.with_options(:action => "show", :requirements => {:id => EVENT_TAG}) do |event|
      event.event ":id"
      event.formatted_event ":id.:format"
    end
    events.formatted_past_events "past-events.:format", :action => "past"
    events.with_options(:requirements => {:event_id => EVENT_TAG}) do |events|
      events.formatted_event_tweets ":event_id/tweets.:format", :controller => "tweets", :action => "index", :conditions => {:method => :get}
      events.formatted_event_photos ":event_id/photos.:format", :controller => "flickr_photos", :action => "index", :conditions => {:method => :get}
    end
  end

  map.with_options(:controller => "rsvps", :requirements => {:event_id => EVENT_TAG}, :path_prefix => ":event_id", :name_prefix => "event_") do |rsvps|
    rsvps.rsvp "rsvp", :action => "show", :conditions => { :method => :get }
    rsvps.rsvp "rsvp", :action => "destroy", :conditions => { :method => :delete }
    rsvps.rsvp "rsvp", :action => "update" # put and post
    rsvps.rsvp_pike "rsvp/pike", :action => "pike", :conditions => {:method => :get}
  end
  
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
  map.resources :users, :as => "people", :collection => {:verify => :any, :details => :get, :create => :post}
  
  map.resource  :mugshot, :name_prefix => 'current_'
  map.resources :mugshots, :member => {:crop => :any}

  map.resources :identity_urls, :collection => {:create => :any}
  map.with_options(:controller => 'pages') do |m|
    m.with_options(:action => 'home') do |home|
      home.home ''
      home.formatted_home 'home.:format'
    end
    m.with_options(:action => 'about') do |about|
      about.formatted_about 'about.:format'
    end
    m.contact      'contact',        :action => 'contact'
    m.open_id      'single-sign-on', :action => 'single-sign-on'
    m.contributors 'contributors',   :action => "contributors"
    m.vote_vis     'votestream',     :action => "votestream"
  end
  map.namespace :admin do |admin|
    admin.resources :events do |event|
      event.resources :rsvps, :proposals, :jams
    end
    admin.resources :posts, :users
  end
  map.admin 'admin', :controller => 'admin/home'
  map.legacy_post 'post/:permalink.html', :controller => "posts", :action => "legacy"
  
  map.root :home
end

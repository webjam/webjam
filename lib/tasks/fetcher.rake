# Boot rails
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")


namespace :fetcher do
  
  desc 'Runs all fetch tasks'
  task :all => [:flickr, :twitter]
  
  desc 'Fetches new images from flickr for all events'
  task :flickr do
    puts "Starting Flickr Fetch"
    Event.find(:all).each {|event| FlickrPhoto.fetch(event)}
  end
  
  desc 'Fetches new tweets from search.twitter for all events'
  task :twitter do
    puts "Starting tweet fetch"
    Event.find(:all).each {|event| Tweet.retrieve(event)}
  end
end

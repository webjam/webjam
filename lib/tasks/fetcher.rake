# Boot rails
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")


namespace :fetcher do
  
  desc 'Runs all fetch tasks'
  task :all => [:flickr, :twitter]
  
  desc 'Fetches new images from flickr for all events'
  task :flickr do
    puts "Starting Flickr Fetch"
    Event.find(:all).each do |event|
      posted_before = Time.at(0) # default to beginning of time, aka. 1970
      latest_photo = event.flickr_photos.find(:first, :order => "posted_before DESC")
      if latest_photo
        posted_before = latest_photo.posted_before
      end
      FlickrPhoto.retrieve_by_tags_newer_than(event.id, [event.tag], posted_before)
    end
  end
  
  desc 'Fetches new tweets from search.twitter for all events'
  task :twitter do
    puts "Starting tweet fetch"
    Event.find(:all).each {|event| Tweet.retrieve(event)}
  end
end

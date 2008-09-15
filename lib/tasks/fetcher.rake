# Boot rails
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")


namespace :fetcher do
  
  desc 'Runs all normal fetch tasks'
  task :all => [:flickr, :twitter, :viddler]
  
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
  
  desc 'Fetches extended info for images that dont have it.'
  task :flickr_extended_info do
    puts "Starting Flickr Extended Info Load."
    license_hash = FlickrPhoto.license_text_hash
    FlickrPhoto.find(:all, :conditions => "realname IS NULL").each do |fp|
      fp.load_extended_info(license_hash)
      fp.save!
    end
  end
  
  desc 'Fetches new videos from viddler for all events'
  task :viddler do
    puts "Starting viddler"
    Event.find(:all).each {|event| ViddlerVideo.fetch_for_event(event)}
  end
end

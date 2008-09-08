require "json"
require "open-uri"
require "cgi"

class Tweet < ActiveRecord::Base
  
  has_one :event
  
  def self.retrieve(event)
    tag = event.tag
    
    since_id = 0
    if latest_tweet_in_db = event.tweets.find(:first, :order => "twitter_identifier DESC")
      since_id = latest_tweet_in_db.twitter_identifier
    end
    
    endpoint = "http://search.twitter.com/search.json"
    call_uri = "#{endpoint}?q=#{CGI.escape("#" + tag)}&since_id=#{since_id}"
    response = JSON.parse(open(call_uri).read)

    response["results"].each do |result|
      tweet = Tweet.new(:body=> result["text"], :username => result["from_user"],
        :twitter_identifier => result["id"].to_i, :posted_at => Time.parse(result["created_at"]),
        :event_id => event.id)
      tweet.save!
    end
  end
end

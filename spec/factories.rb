require 'factory_girl'

Factory.define :user do |u|
  u.nick_name {Factory.next(:nick_name)}
  u.email {Factory.next(:email)}
  u.full_name 'Full name'
end

Factory.define(:identity_url) do |iu|
  iu.url {Factory.next(:identity_url)}
  iu.association :user
end

Factory.define :post do |u|
  u.title "Title"
  u.body "<p>Body</p>"
  u.published_at Time.now.utc
  u.permalink {|a| "#{a.published_at.year}-#{Factory.next(:permalink)}"}
  u.association :user
end

Factory.define :post_comment, :class => Comment do |c|
  c.body "Me too!"
  c.association :user
  c.association :commentable, :factory => :post
end

Factory.define :event do |e|
  e.name {"Webjam #{Factory.next(:event_number)}"}
  e.tag {"webjam#{Factory.next(:event_number)}"}
  e.location "Sydney"
  e.hype "<p>Buy it.</p>"
  e.timezone "Sydney"
  e.published_at Time.now.utc
  e.map_iframe_url "http://iframe.com"
  e.map_url "http://map.com"
end

Factory.sequence(:email) {|n| "user#{n}@domain.com"}
Factory.sequence(:nick_name) {|n| "nick_name_#{n}"}
Factory.sequence(:permalink) {|n| "permalink_#{n}"}
Factory.sequence(:event_number) {|n| n}
Factory.sequence(:identity_url) {|n| "http://openid-provider-#{n}.com"}
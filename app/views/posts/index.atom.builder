atom_feed(:language => "en-AU") do |feed|
  feed.title "Webjam"
  feed.updated @posts.first.published_at
  for post in @posts
    feed.entry(post, :published => post.published_at, :url => post_url(:year => post.year, :permalink => post.permalink)) do |entry|
      entry.title post.title
      entry.content post.body, :type => 'html'
      entry.author do |author|
        author.name post.user.nick_name
        author.uri user_url(post.user)
      end
    end
  end
end

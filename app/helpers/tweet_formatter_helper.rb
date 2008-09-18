module TweetFormatterHelper
  # From Alex
  # http://groups.google.com/group/twitter-development-talk/msg/eb0409891c5e18e3?dmode=source
  URL_MATCH = %r{
   (                          # leading text
     <\w+.*?>|                # leading HTML tag, or
     [^=!:'"/]|               # leading punctuation, or
     ^                        # beginning of line
   )
   (
     (?:https?://)|           # protocol spec, or
     (?:www\.)                # www.*
   )
   (
     [-\w]+                   # subdomain or domain
     (?:\.[-\w]+)*            # remaining subdomains or domain
     (?::\d+)?                # port
     (?:/(?:(?:[~\w\+%-]|(?:[,.;@:][^\s$]))+)?)* # path
     (?:\?[\w\+%&=.;:-]+)?    # query string
     (?:\#[\w\-\.]*)?         # trailing anchor
   )
   ([[:punct:]]|\s|<|$)       # trailing text
  }x
  USERNAME_MATCH = %r{@([-\w]+)}
  def format_tweet(tweet)
    tweet.gsub(URL_MATCH, '\1<a href="\0">\2\3</a>\4').gsub(USERNAME_MATCH, '<a href="http://twitter.com/\1">\0</a>')
  end
end

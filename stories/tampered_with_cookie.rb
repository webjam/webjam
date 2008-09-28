require File.join(File.dirname(__FILE__), "story_helper")

with_steps_for :tampered_with_cookie do
  run File.expand_path(__FILE__).gsub("rb", "story"), :type => RailsStory
end

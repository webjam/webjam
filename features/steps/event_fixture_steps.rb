Given "there is a past event" do
  Factory.create(:event, :held_at => 1.day.ago, :proposals_close_at => 2.days.ago)
end

Given "there is an upcoming event" do
  Factory.create(:event, :held_at => Time.now.utc + 2.days, :proposals_close_at => Time.now.utc + 1.day)
end

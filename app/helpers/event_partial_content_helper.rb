module EventPartialContentHelper
  def sponsor_content(event)
    if File.exist?("#{RAILS_ROOT}/app/views/events/#{event.tag}/_sponsors.html.haml")
      render :partial => "events/#{event.tag}/sponsors.html.haml"
    end
  end
  def sponsor_major_content(event)
    if File.exist?("#{RAILS_ROOT}/app/views/events/#{event.tag}/_sponsors_major.html.haml")
      render :partial => "events/#{event.tag}/sponsors_major.html.haml"
    end
  end
  def winners_content(event)
    if File.exist?("#{RAILS_ROOT}/app/views/events/#{event.tag}/_winners.html.haml")
      render :partial => "events/#{event.tag}/winners.html.haml"
    end
  end
  def event_summary(event)
    if File.exist?("#{RAILS_ROOT}/app/views/events/#{event.tag}/_summary.html.haml")
      render :partial => "events/#{event.tag}/summary.html.haml"
    end
  end
end

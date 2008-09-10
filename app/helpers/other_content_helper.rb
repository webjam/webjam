module OtherContentHelper
  def default_other_content
    render(:partial => 'shared/other_content/upcoming_events') +
    render(:partial => 'shared/other_content/latest_news')
  end
end

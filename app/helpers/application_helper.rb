module ApplicationHelper
  def user_link_with_avatar(user, classes="")
    render :partial => "shared/user_avatar",
           :locals => {:user => user, :classes => classes}
  end

  def user_login_link_with_avatar(user)
    render :partial => "shared/user_login_avatar",
           :locals => {:user => user}
  end
  
  def avatar_image(user, size=:tiny)
    raise(ArgumentError, "user can not be nil") if user.nil?
    # image_tag(user.mugshot ? user.mugshot.url(size) : "default_avatar_#{size || 'large'}.gif", :alt => h(user.nick_name), :class => 'photo')
    image_tag(user.mugshot.url(size), :alt => h(user.nick_name), :class => 'photo')
  end
  
  def flash_notice
    %(<div class="notice">#{h flash[:notice]}</div>) if flash[:notice]
  end
  def hidden_return_to(anchor=nil)
    hidden_field_tag 'return_to', @request.request_uri + (anchor ? "##{anchor}" : "")
  end
  def time_to_event(event)
    days = (event.held_at - Time.now.utc) / 60 / 60 / 24
    if days == 0
      "OMG it's today"
    elsif days < 1.0
      "OMG it's tomorrow!"
    else
      "#{days.round} days to go"
    end
  end
  def link_to_login_with_return_to_current_page(content)
    link_to content, new_session_path(:return_to => request.request_uri)
  end
end
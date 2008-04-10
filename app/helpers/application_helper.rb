module ApplicationHelper

  def user_link_with_avatar(user, classes="")
    render :partial => "shared/user_avatar",
           :locals => {:user => user, :classes => classes}
  end

  def user_login_link_with_avatar(user)
    # link_to "Hi #{avatar_image(user)}&nbsp;<strong class='fn nickname'>#{h(user.nick_name)}</strong>!", user_path(user), :class => 'user-avatar vcard'
    render :partial => "shared/user_login_avatar",
           :locals => {:user => user}
  end
  
  def avatar_image(user, size=:tiny)
    raise(ArgumentError, "user can not be nil") if user.nil?
    image_tag(user.mugshot ? user.mugshot.public_filename(size) : "default_avatar_#{size || 'large'}.gif", :alt => h(user.nick_name), :class => 'photo')
  end
  
  
  # I just know there's a better way to do this... Help?
  def user_link_for_comment(user, classes="")
    classes += " user-avatar vcard"
    link_to "#{avatar_image(user, :medium)}&nbsp;<span class='fn nickname'>#{h(user.nick_name)}</span>", user_path(user), :class => classes.strip
  end
  # end lameness ;)
  
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

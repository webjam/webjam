module ApplicationHelper
  def user_link_with_avatar(user, classes="")
    classes += " user-avatar"
    link_to "#{avatar_image(user)}&nbsp;#{h(user.nick_name)}", user_path(user), :class => classes.strip
  end
  def user_login_link_with_avatar(user)
    link_to "Hi #{avatar_image(user)}&nbsp;<strong>#{h(user.nick_name)}</strong>!", user_path(user), :class => 'user-avatar'
  end
  def avatar_image(user, size=:tiny)
    raise(ArgumentError, "user can not be nil") if user.nil?
    image_tag(user.mugshot ? user.mugshot.public_filename(size) : "default_avatar_#{size || 'large'}.gif", :alt => h(user.nick_name))
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

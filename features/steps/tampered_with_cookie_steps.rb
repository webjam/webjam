require 'cgi'  
require 'cgi/session'  
class CGI::Session::CookieStore
  # Emulate Rails throwing a TamperedWithCookie exception
  def unmarshal_with_raise_tampered_with_cookie(*args)
    raise CGI::Session::CookieStore::TamperedWithCookie
  end
end

Given "I am naughty" do
end

When "I view the home page with a tampered cookie" do
  CGI::Session::CookieStore.class_eval { alias_method_chain :unmarshal, :raise_tampered_with_cookie}
  lambda { get(home_path) }.should_not raise_error
  CGI::Session::CookieStore.class_eval { alias_method :unmarshal_without_raise_tampered_with_cookie, :unmarshal}
end

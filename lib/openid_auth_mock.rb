OpenIdAuthentication.module_eval do
  def authenticate_with_open_id(identity_url, fields)
    yield OpenIdAuthentication::Result[:successful], identity_url, nil
  end
end
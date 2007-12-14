OpenIdAuthentication.module_eval do
  protected
    def authenticate_with_open_id(identity_url, fields=nil)
      yield OpenIdAuthentication::Result[:successful], identity_url, nil
    end
end
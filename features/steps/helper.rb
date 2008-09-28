# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'

Before do
  ActionMailer::Base.deliveries.clear
end

# Override Cucumbers version of this to allow rescue_from's to be called
ActionController::Base.class_eval do
  def perform_action
    perform_action_without_rescue
  rescue Exception => exception
    rescue_action_with_handler(exception) || raise
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../../spec/factories')

# Our own little additions
ActionController::Integration::Session.class_eval do
  def iphone_user_agent
    "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
  end
  def login(user)
    begin
      ApplicationController.class_eval do
        def authenticate_with_open_id_with_mocked_result(url, *args)
          yield OpenIdAuthentication::Result.new(:successful), url
        end
        alias_method_chain :authenticate_with_open_id, :mocked_result
      end
      post create_session_path(:openid_url => user.identity_urls.first.url)
      response.should be_redirect
    ensure
      # Undo the alias_method_chain'ing
      ApplicationController.send(:alias_method, :authenticate_with_open_id_without_mocked_result, :authenticate_with_open_id)
    end
  end
end
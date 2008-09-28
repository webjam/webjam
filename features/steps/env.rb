# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'

# Override Cucumbers version of this to allow rescue_from's to be called
ActionController::Base.class_eval do
  def perform_action_with_rescue #:nodoc:
    perform_action_without_rescue
  rescue Exception => exception
    rescue_action_with_handler(exception) || raise
  end
end

# Our own little additions
ActionController::Integration::Session.class_eval do
  def admin_user
    @user ||= begin
      user = User.new(
        :nick_name => "god",
        :email => "god@heaven.com",
        :full_name => "The Big G"
      )
      user.admin = true
      user.save!
      user
    end
  end
  def post(user)
    post = user.posts.create!(
      :title => "The greatest post",
      :body => "<p>What is it about the greatest post</p>",
      :published_at => Time.now.utc,
      :permalink => "some-great-post"
    )
  end
  def post_before(post, user)
    post = post(user)
    post.update_attribute(:published_at, post.created_at - 1.day)
    post
  end
  def post_after(post, user)
    post = post(user)
    post.update_attribute(:published_at, post.created_at + 1.day)
    post
  end
  def comment(post, user)
    comment = post.comments.build(:body => "Me too!")
    comment.user = user
    comment.save!
    comment
  end
  def iphone_user_agent
    "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
  end
  def login(user)
    raise "Pending"
    # with_mocked_authenticate_with_open_id(:successful) do
    # end
  end
  def with_mocked_authenticate_with_open_id(result_code)
    # Mock using alias_method_chain
    ApplicationController.class_eval do
      def authenticate_with_open_id_with_mocked_result(url, *args)
        yield OpenIdAuthentication::Result.new(result_code, url)
      end
      alias_method_chain :authenticate_without_open_id, :mocked_result
    end
    yield
  ensure
    # Undo the alias_method_chain
    ApplicationController.send(:alias_method, :authenticate_with_open_id_without_mocked_result, :authenticate_with_open_id)
  end
end
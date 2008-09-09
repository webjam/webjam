class ApplicationController < ActionController::Base
  class NotFound < StandardError; end
  
  include ExceptionNotifiable
  
  include AuthenticatedSystem
  before_filter :login_from_cookie

  helper :all
  
  rescue_from ActiveRecord::RecordNotFound, NotFound do
    render :file => File.join(RAILS_ROOT, "public", "404.html"), :status => :not_found
  end
  
  protected
    TLD_LENGTH = 2
    
    before_filter :protect_da_alpha
    def protect_da_alpha
      authenticate_or_request_with_http_basic {|u, p| u == "alpha" && p == "alpha"}
    end
    
    before_filter :remove_trailing_slashes
    def remove_trailing_slashes
      if (uri = request.request_uri).length > 1 and uri[-1,1] == '/'
        redirect_to uri.chop, :status => 301
        return false
      end
    end
    
    before_filter :no_www
    def no_www
     if (bad_subdirs = ["ww", "www"]).any? {|s| [s]==request.subdomains(TLD_LENGTH)}
        redirect_to :host => request.domain(TLD_LENGTH), :status => 301
       return false
     end
    end
    
    before_filter :set_next_events_for_header
    def set_next_events_for_header
      @header_next = Event.all(:order => "held_at ASC", :conditions => ["held_at >= ? AND published_at IS NOT NULL", Time.now], :limit => 1)
    end
    
    before_filter :set_latest_blog_post_fo_shizzle
    def set_latest_blog_post_fo_shizzle
      @latest_post = Post.published.latest
    end
    
    before_filter :set_footer_events
    def set_footer_events
      @footer_events = Event.published.all
    end

    before_filter :set_latest_news_for_footer
    def set_latest_news_for_footer
      @footer_latest_news = Post.published.latest(5)
    end
    
    def render_404
      render :file => "#{RAILS_ROOT}/public/404.html", :status => :not_found
    end
    
    def strip_permalinks
      params[:id] = params[:id].split('-').first if params[:id]
      true
    end
    
    def iphone_request?
      params[:no_iphone].nil? && request.headers['User-Agent'] && request.headers['User-Agent'].include?("iPhone")
    end
end

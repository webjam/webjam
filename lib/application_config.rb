class ApplicationConfig
  attr_reader :flickr_api_key, :jeeves_campfire_password
  
  def initialize
    y = YAML::load(File.open(File.dirname(__FILE__) + '/../config/application.yml'))
    @flickr_api_key = y['flickr_api_key']
    @jeeves_campfire_password = y['jeeves_campfire_password']
  end
end

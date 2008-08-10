class ApplicationConfig
  attr_reader :flickr_api_key
  
  def initialize
    y = YAML::load(File.open(RAILS_ROOT + '/config/application.yml'))
    @flickr_api_key = y['flickr_api_key']
  end
end
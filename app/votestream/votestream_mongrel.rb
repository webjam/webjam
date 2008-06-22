require 'rubygems'
require 'mongrel'

module Webjam
  CONTESTANTS = {"1" => "Elvis", "2" => "why", "3" => "Zed", "4" => "Jesus"}
  
  class Total
    attr_accessor :code, :name, :total
    def initialize(code, name)
      @code, @name, @total = code, name, rand(100)
    end
    def to_json
      %({"name":"#{name}","code":"#{code}","totalVotes":"#{total}"})
    end
    def self.all
      CONTESTANTS.map {|code, name| Total.new(code, name)}
    end
  end
  
  class Updates
    attr_accessor :code, :update
    def initialize(code)
      @code, @update = code, rand(10)
    end
    def to_json
      %({"code":"#{code}","newVotes":"#{update}"})
    end
    def self.all
      CONTESTANTS.keys.select { rand(2) == 1 }.map {|code| new(code)}
    end
  end

  module JsonOutput
    def json(request, defaultCallback, json)
      params = Mongrel::HttpRequest.query_parse request.params["QUERY_STRING"]
      "#{params["callback"] || defaultCallback}(#{json});\n"
    end
  end

  class TotalHandler < Mongrel::HttpHandler
    include JsonOutput
    def process(request, response)
      response.start do |head,out|
        head["Content-Type"] = "text/javascript"
        out << json(request, "votestreamTotals", "[#{Total.all.map {|t| t.to_json}.join(",")}]");
      end
    end
  end

  class UpdateHandler < Mongrel::HttpHandler
    include JsonOutput
    
    def process(request, response)
      response.status = 200
      response.send_status(false)
      response.header["Content-Type"] = "text/html"
      response.send_header

      response.write("\n" * 5000) # For safari
      response.socket.flush

      loop do
        response.write %(<script type="text/javascript">\n  ) + json(request, "votestreamUpdates", "[#{Updates.all.map {|c| c.to_json}.join(",")}]") + "</script>\n"
        response.socket.flush
        sleep 1
      end

      response.done = true
    end
  end
end

host = "0.0.0.0"
port = 3333

config = Mongrel::Configurator.new :host => host, :port => port do
  listener do
    uri "/votes/totals", :handler => Webjam::TotalHandler.new
    uri "/votes/updates", :handler => Webjam::UpdateHandler.new
  end
  trap("INT") { stop }
  puts "Serving Votestream on http://#{host}:#{port}"
  run
end

config.join
#/usr/bin/env ruby
#
# A sample emitter for the voting vis feed
#
# We want some kind of server that understands HTTP and emits this JSON incrementally
#
# It needs to take a format parameter to specify straight JSON or JSON-P

FORMAT = :json_p # :json or :json_p

class Contestant
  attr_accessor :code, :name, :votes
  def initialize(code, name)
    @code, @name, @votes = code, name, 0
  end
  def to_json
    %({"name":"#{name}","code":"#{code}","votes":"#{votes}"})
  end
end

contestants = []

%w( Elvis why Zed Jesus ).each_with_index do |name, index|
  contestants << Contestant.new(index+1, name)
end

(1..50).each do |loop|
  contestants.each {|c| c.votes += rand(5) } # Increment the votes

  js = contestants.map {|c| c.to_json}.join(",")

  if FORMAT == :json
    puts js
  elsif FORMAT == :json_p
    puts %(<script type="text/javascript">updateWebjamVotes\([#{js}]\);</script>)
  end

  sleep(3)
end
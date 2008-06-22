module Webjam
  class Contestant
    attr_accessor :code, :name, :votes
    def initialize(code, name)
      @code, @name, @votes = code, name, 0
    end
    def to_json
      %({"name":"#{name}","code":"#{code}","votes":"#{votes}"})
    end
  end
  
  class Votestream
    def each
      contestants = []

      %w( Elvis why Zed Jesus ).each_with_index do |name, index|
        contestants << Contestant.new(index+1, name)
      end

      contestants.each {|c| c.votes += rand(5) } # Increment the votes

      js = contestants.map {|c| c.to_json}.join(",")

      yield js
      # if FORMAT == :json
        
      # elsif FORMAT == :json_p
        # yield %(<script type="text/javascript">updateWebjamVotes\([#{js}]\);</script>)
      # end
    end
  end
end

require 'rubygems'
require 'thin'

class SimpleAdapter
  def each
    loop do
      STDERR.puts "Loop"
      yield "Hello\n" * 1000
      sleep(1)
    end
  end
  def call(env)
    [200, {'Content-Type' => 'text/plain'}, self]
  end
end

Thin::Server.start('0.0.0.0', 9292) do
  map '/' do
    run SimpleAdapter.new
  end
end

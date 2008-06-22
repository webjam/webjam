require 'thin'
require 'votestream'

use Rack::ShowExceptions
run Webjam::Votestream.new

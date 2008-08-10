module Webjam
  module PaperclipHacks
    def delete
      send :queue_existing_for_delete
    end
  end
end
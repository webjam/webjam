require 'hacks/paperclip_hacks'

Paperclip::Attachment.send :include, Webjam::PaperclipHacks
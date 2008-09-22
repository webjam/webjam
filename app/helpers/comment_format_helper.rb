module CommentFormatHelper
  def format_comment_body(body)
    sanitize simple_format(body), :tags => %w(p strong em a code pre blockquote span q abbr acronym br img ul ol li del br), :attributes => %w(href class cite rel rev title src alt)
  end
end

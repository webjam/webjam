module UserHtmlFormatHelper
  def format_user_html(html)
    sanitize simple_format(html), :tags => %w(p strong em a code pre blockquote span q abbr acronym br img ul ol li del br), :attributes => %w(href class cite rel rev title src alt)
  end
end

module UnicodeTranslitHelper
  def utf8_translit(str)
    Iconv.new('ascii//translit', 'utf-8').iconv(str)
  end
  def utf8_slugify(str)
    utf8_translit(str).gsub(/\s+/,'-').gsub(/[^A-Za-z0-9-]/,'')
  end
end

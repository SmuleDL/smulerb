#!/usr/bin/env ruby

require "http"
require "nokogiri"

class LinkConverter
  def initialize(original_link)
    @original_link = original_link
  end

  def get_source
    HTTP.get(@original_link).to_s 
  end

  def parse_link
    document = Nokogiri::HTML(get_source)
    link = document.at('meta[name="twitter:player:stream"]')['content']
    title = document.at('meta[name="twitter:description"]')['content']
    meta = {link: link, title: title.split(".")[0]}
  end
end

class AudioHandler
  def initialize(meta)
    @title = meta[:title]
    @link = meta[:link]
  end

  def get_audio
    audio = HTTP.follow.get(@link)
    File.open(@title, 'wb') do |f|
      f.write(audio.body)
    end
  end

end

link = ARGV[0]
s = LinkConverter.new(link)
a = AudioHandler.new(s.parse_link)
a.get_audio
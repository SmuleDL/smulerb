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
  end

	def parse_title
		document = Nokogiri::HTML(get_source)
		document.at('meta[name="twitter:description"]')['content'].split("on Sing")[0].strip
	end
end

class AudioHandler
  def initialize(link, title)
    @title = title
    @link = link
  end

	def get_binary
     HTTP.follow.get(@link) # get the binary blob file from link
	end

  def get_audio
		audio = get_binary
    File.open(@title, 'wb') do |f|
      f.write(audio.body)
    end
  end
end

link = ARGV[0]
s = LinkConverter.new(link)
a = AudioHandler.new(s.parse_link, s.parse_title)
a.get_audio

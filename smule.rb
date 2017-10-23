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
    document.at('meta[name="twitter:player:stream"]')['content']
  end
end

class AudioHandler
  def initialize(link)
    @link = link
  end

  def get_audio
    audio = HTTP.follow.get(@link)
    File.open('output.mp4', 'wb') do |f|
      f.write(audio.body)
    end
  end

end

link = ""
s = LinkConverter.new(link)
a = AudioHandler.new(s.parse_link)
a.get_audio
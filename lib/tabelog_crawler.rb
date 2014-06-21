require "net/http"
require "nokogiri"
require "geocoder"

USER_AGENT = "hungrybot"

class TabelogCrawler
  def initialize
    @result = Struct.new("Result", :name, :latitude, :longitude)
  end

  def run(url_string)
    uri = URI.parse(url_string)
    response = Net::HTTP.new(uri.host).get(uri.path, { "User-Agent" => USER_AGENT })
    document = Nokogiri::HTML(response.body)

    puts response.body

    table = document.xpath("//table[@class='rst-data']")
    name = table.xpath("//tr[@class='rst-name table-first']/td").inner_text.strip

    address = table.xpath("//tr[@class='address']/td/p")
    region = address.xpath("//span[@property='v:region']").inner_text.strip
    locality = address.xpath("//span[@property='v:locality']").inner_text.strip
    location = Geocoder.search(region + locality).first
    latitude, longitude = location.coordinates if location.present?

    @result.new(name, latitude, longitude)
  end
end


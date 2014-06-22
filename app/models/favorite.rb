require "tabelog_proxy_crawler"

class Favorite < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  before_validation :crawl_tabelog

  reverse_geocoded_by :latitude, :longitude

  def pushover(user_token)
    Pushover.notification(
      title: self.name,
      message: self.google_maps_link,
      user: user_token
    )
  end

  def google_maps_link
    "https://www.google.com/maps/preview?q=#{self.latitude},#{self.longitude}"
  end

  private

  def crawl_tabelog
    # TODO: Enumerate the list of proxy servers until crawling successes
    crawler = TabelogProxyCrawler.new("98.143.148.82", 7808)
    result = crawler.run(self.url)
    self.name = result.name
    self.latitude = result.latitude
    self.longitude = result.longitude
  end
end

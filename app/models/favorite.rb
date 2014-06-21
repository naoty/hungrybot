require "tabelog_crawler"

class Favorite < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  before_validation :crawl_tabelog

  private

  def crawl_tabelog
    crawler = TabelogCrawler.new
    result = crawler.run(self.url)
    self.name = result.name
    self.latitude = result.latitude
    self.longitude = result.longitude
  end
end

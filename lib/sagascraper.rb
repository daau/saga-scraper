require "pry-byebug"
require "nokogiri"
require "open-uri"
require "awesome_print"
require_relative "sagascraper/scraper"
require_relative "sagascraper/display"

module SagaScraper
  ROOT_URL = "https://maplesaga.com"
  EQUIPMENT_URL = "https://maplesaga.com/library/equip"
  ITEM_URL = "https://maplesaga.com/library/item"
    
  class Application
    def call
      # Display.header("Obtaining equipment data...")
      # equipment_scraper = Scraper.new(type: :equipment)
      # equipment_scraper.scrape
      # equipment_scraper.export_data("export/equipment.json")

      Display.header("Obtaining item data...")
      item_scraper = Scraper.new(type: :item)
      item_scraper.scrape
      item_scraper.export_data("export/item.json")
    end
  end
end

SagaScraper::Application.new.call

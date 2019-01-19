require_relative './category/category_scraper'
require_relative './category/category'
require_relative './entry/entry_scraper'
require_relative './entry/entry'

module SagaScraper
  class Scraper
    attr_accessor :type, :categories

    def initialize(args)
      @type = args[:type]
      @categories = []
    end

    def scrape
      scrape_for_categories
      scrape_categories_for_entries
    end

    def export_data(filepath)
      File.open(filepath, "wb") { |file| file.puts JSON.pretty_generate(self.to_json) }
    end

    def to_json
      { categories: @categories.map(&:to_json) }
    end    

    private

    def scrape_for_categories
      category_scraper = ScraperFactory.for(type: @type)
      @categories = category_scraper.get_categories
    end

    def scrape_categories_for_entries
      @categories.each do |category|
        puts category.name.red
        EntryScraperFactory.for(type: @type, category: category).scrape
      end
    end
  end
end
module SagaScraper
  class Scraper
    attr_accessor :type, :categories

    def initialize(arg)
      @type = arg[:type]
      @categories = []
    end

    def scrape
      scrape_for_categories
      scrape_categories_for_entries
    end

    def export_data(filepath)
      File.open(filepath, "wb") { |file| file.puts JSON.pretty_generate(self.to_json) }
    end  

    private

    def scrape_for_categories
      category_scraper = Scraper.for(type: @type)
      @categories = category_scraper.get_categories
    end

    def scrape_categories_for_entries
      @categories.each do |category|
        EntryScraper.for(type: @type).scrape(category: category)
      end
    end

    def to_json
      { categories: @categories.map(&:to_json) }
    end  
  end
end
module SagaScraper
  class Scraper
    def self.for(args)
      case args[:type]
      when :equipment
        EquipmentCategoryScraper.new
      when :item
        ItemCategoryScraper.new
      end
    end
  end


  class CategoryScraper
    attr_accessor :url, :page

    def initialize(args)
      @categories = []
    end

    def get_categories
      load_page
      scrape_for_categories
      @categories
    end

    private

    def load_page
      @page = Timeout::timeout(10) do
        Nokogiri::HTML(open(@url))
      end      
    end
  end


  class EquipmentCategoryScraper < CategoryScraper
    def initialize
      @url = EQUIPMENT_URL
      super
    end

    def scrape_for_categories
      @page.css('.container-fluid > .row > .row > a').each do |element|
        name = element.children[1].children[0].text.strip

        relative_path = element.attributes["href"].value
        url = ROOT_URL + relative_path

        @categories << Category.new(url, name)
      end
    end
  end


  class ItemCategoryScraper < CategoryScraper
    def initialize
      @url = ITEM_URL
      super
    end

    def scrape_for_categories
    end
  end
end
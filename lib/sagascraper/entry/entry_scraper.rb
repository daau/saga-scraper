module SagaScraper
  class EntryScraperFactory
    def self.for(args)
      case args[:type]
      when :equipment
        EquipmentEntryScraper.new(args[:category])
      when :item
        ItemEntryScraper.new(args[:category])
      end
    end
  end



  class EntryScraper
    attr_accessor :category, :url, :page

    def initialize(category)
      @category
      @url = @category.url
    end

    def scrape
      load_page
      @category.entries = get_entries
    end

    private

    def load_page
      @page = Timeout::timeout(10) do
        Nokogiri::HTML(open(@url))
      end      
    end  
  end



  class EquipmentEntryScraper < EntryScraper

    private

    def get_entries
      entries = []

      @page.css('.').each do |page_element|
        entries << Entry.new.tap do |entry|

        end
      end

      entries
    end

    def get_data
      @id = get_id
      @name = get_name
      @image_url = ROOT_URL + get_relative_image_url
      
      if @element.css("tr").count > 6 || @element.css("tr").count < 5
        raise InvalidTableError, "Invalid number of rows! (there were #{@element.css("tr").count} rows)"
      end
      
      puts @name.white
    end

    def get_id
      @element.attributes["id"].value
    end

    def get_name
      @element.css("tr")[0].children[3].children[1].children[0].text
    end

    def get_image_url
      ROOT_URL + @element.children[1].children[1].children[1].children[1].attributes["src"].value
    end   
  end



  class ItemEntryScraper < EntryScraper
    def scrape
    end

    private
  end
end
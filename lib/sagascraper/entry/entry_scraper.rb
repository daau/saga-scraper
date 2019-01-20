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
      @category = category
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
      @page.css('table').each do |el|
        entries << entry = Equipment.new.tap do |entry|
          entry.id            = get_id(el)
          entry.name          = get_name(el)
          entry.image_url     = get_image_url(el)
          entry.wearable_by   = get_wearable_by(el)
          entry.requirements  = get_wearable_by(el)
          entry.stats         = get_stats(el)
          entry.dropped_by    = get_dropped_by(el)
          entry.obtained_from = get_obtained_from(el)
          entry.remarks       = get_remarks(el)
        end

        puts entry.name
      end

      entries
    end

    def get_id(element)
      element.attributes["id"].value.to_i
    end

    def get_name(element)
      element.css("tr")[0].children[3].children[1].children[0].text.strip
    end

    def get_image_url(element)
      ROOT_URL + element.children[1].children[1].children[1].children[1].attributes["src"].value
    end

    def get_wearable_by(element)
      element.children[1].children[3].children[1].children[1].children[1].text.strip
    end

    def get_requirements(element)
      element.children[1].children[3].children[1].children[3].children[1].text.strip
    end

    def get_stats(element)
      element.children[1].children[5].children[1].children[2].text.strip
    end

    def get_dropped_by(element)
      element.children[1]
             .children[7]
             .children[1]
             .children
             .select{|e| e.class != Nokogiri::XML::Text && e.name == "a"}
             .map{|e| e.children[0].text.strip}
             .join(", ")
    end

    def get_obtained_from(element)
      return nil if element.css("tr").count == 5
      element.children[1].children[9].children[1].children[2].text.strip
    end

    def get_remarks(element)
      index = element.css("tr").count == 5 ? 9 : 11
      element.children[1].children[index].children[1].children[2].text.strip
    end
  end

  class InvalidTableError < StandardError
  end

  class ItemEntryScraper < EntryScraper
    private

    def get_entries
      entries = []
      @page.css('table').each do |el|
        entries << entry = Item.new.tap do |entry|
          entry.id            = get_id(el)
          entry.name          = get_name(el)
          entry.image_url     = get_image_url(el)
          entry.description   = get_description(el)
          entry.dropped_by    = get_dropped_by(el)
          entry.obtained_from = get_obtained_from(el)
          entry.remarks       = get_remarks(el)
        end

        puts entry.name
      end

      entries      
    end

    def get_id(element)
      element.attributes["id"].value.to_i
    end

    def get_name(element)
      element.css("strong")[0].children[0].text.strip
    end

    def get_image_url(element)
      ROOT_URL + element.css("img")[0].attributes["src"].value
    end

    def get_description(element)
      element.css("tr")[1].children[1].children[0].text.strip
    end

    def get_dropped_by(element)
      begin
        element.css("tr")[2]
               .children[1]
               .children
               .select{|e| e.class != Nokogiri::XML::Text && e.name == "a"}
               .map{|e| e.children[0].text.strip}
               .join(", ")
      rescue NoMethodError
        nil
      end
    end

    def get_obtained_from(element)
      return nil if element.css("tr").count < 4
      return unless element.css("tr strong")[2].children.text.strip == "Obtained from:"
      element.css("tr")[3].children[1].children[2].text.strip
    end

    def get_remarks(element)
      return nil if element.css("tr").count < 4
      return unless element.css("tr strong")[2].children.text.strip == "Remarks:"
      element.css("tr")[3].children[1].children[2].text.strip
    end
  end
end
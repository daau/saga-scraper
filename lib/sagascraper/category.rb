require "nokogiri"
require "open-uri"
require_relative "equipment"
require_relative "errors"
require_relative "display"

module SagaScraper
  class Category
    attr_accessor :url, :name, :equipment, :page

    def initialize(url, name)
      @url = url
      @name = name
      @equipments = []
      @page = nil
    end

    def get_page
      @page = Timeout::timeout(6) do
        Nokogiri::HTML(open(@url))
      end      
    end

    def scrape_for_equipment_data
      Display.print_subheader "Scraping for #{@name} data..."
      get_page
      get_equipments
      get_equipment_data
    end

    def get_equipments
      @page.css("table").each do |element|
        @equipments << Equipment.new(element)
      end
    end

    def get_equipment_data
      @equipments.each {|eq| eq.get_data}
    end
  end
end
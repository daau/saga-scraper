require "nokogiri"
require "open-uri"
require_relative "equipment"
require_relative "errors"
require_relative "display"

module SagaScraper
  class Category
    attr_accessor :equipment, :page

    def initialize(url, name)
      @url = url
      @name = name

      @equipments = []
    end

    def scrape_for_equipment_data
      Display.print_subheader "Scraping for #{@name}..."

      page = Nokogiri::HTML(open(@url))
      elements = page.css("table")

      elements.each do |element|
        equipment = Equipment.new.tap do |u|
        end
      end
    end

    def get_data_from_elements
    end
  end
end
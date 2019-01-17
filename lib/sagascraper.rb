require "pry-byebug"
require "nokogiri"
require "open-uri"
require "awesome_print"
require_relative "sagascraper/category"
require_relative "sagascraper/display"

module SagaScraper
  ROOT_URL = "https://maplesaga.com"
  EQUIPMENT_URL = "https://maplesaga.com/library/equip"
    
  class Application
    attr_accessor :categories, :page

    def initialize
      @categories = []
      @page = nil
    end

    def call
      Display.print_header "Initializing..."
      get_page
      get_equipment_categories_and_links

      Display.print_header "Scraping pages for data..."
      scrape_categories_for_equipment_data

      Display.print_header "Exporting data..."
      # export_equipment_categories_and_links
    end

    def get_page
      @page = Timeout::timeout(6) do
        Nokogiri::HTML(open(EQUIPMENT_URL))
      end
    end

    def get_equipment_categories_and_links
      @page.css('.container-fluid > .row > .row > a').each do |element|
        category_name = element.children[1].children[0].text.strip

        category_relative_url = element.attributes["href"].value
        category_full_url = ROOT_URL + category_relative_url

        @categories << Category.new(category_full_url, category_name)
      end
    end

    def scrape_categories_for_equipment_data
      @categories.each { |category| category.scrape_for_equipment_data }
    end

    def export_equipment_categories_and_links
      File.open("export.json", "wb") { |file| file.puts JSON.pretty_generate(self.to_json) }
    end

    def to_json
      {
        categories: @categories.map(&:to_json)
      }
    end
  end
end


SagaScraper::Application.new.call
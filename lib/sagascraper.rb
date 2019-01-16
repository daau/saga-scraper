require "pry-byebug"
require "nokogiri"
require "open-uri"
require "awesome_print"
require_relative "sagascraper/category"
require_relative "sagascraper/display"

module SagaScraper
  class Application
    ROOT_URL = "https://maplesaga.com"
    attr_accessor :categories, :page

    def initialize
      @categories = []
      @page = Timeout::timeout(6) do
        puts "Getting equipment page...".white
        Nokogiri::HTML(open(equipment_url))
        puts "Done!".white
      end
    end

    def call(equipment_url)
      Display.print_header "Starting program..."
      get_equipment_categories_and_links(equipment_url)

      Display.print_header "Scraping categories for data..."
      scrape_categories_for_equipment_data

      Display.print_header "Exporting data..."
      # export_equipment_categories_and_links
    end

    def get_equipment_categories_and_links(equipment_url)
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
    end
  end
end

equipment_url = 'https://maplesaga.com/library/equip'
SagaScraper::Application.new.call(equipment_url)
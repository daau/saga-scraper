require "nokogiri"
require "open-uri"
require_relative "equipment"
require_relative "errors"
require_relative "display"

module SagaScraper
  class Category
    attr_accessor :url, :name, :equipment

    def initialize(url, name)
      @url = url
      @name = name
      @equipments = []
    end

    def to_json
      {
        name: @name,
        equipments: @equipments.map(&:to_json)
      }
    end
  end
end

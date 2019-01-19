require "nokogiri"
require "open-uri"
require_relative "../entry/entry"

module SagaScraper
  class Category
    attr_accessor :url, :name, :entries

    def initialize(url, name)
      @url      = url
      @name     = name
      @entries  = []
    end

    def to_json
      {
        name:     @name,
        url:      @url,
        entries:  @entries.map(&:to_json)
      }
    end
  end
end

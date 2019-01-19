require "nokogiri"
require "open-uri"
require_relative "errors"

module SagaScraper
  class Equipment
    attr_accessor :element, :id, :name, :image_url, :wearable_by, :requirements, :stats,
      :dropped_by, :obtained_from, :remarks

    def initialize(element)
      @element = element
      @id = nil
      @name = nil
      @image_url = nil
      @wearable_by = nil
      @requirements = nil
      @stats = nil
      @dropped_by = []
      @obtained_from = nil
      @remarks = nil
    end

    def to_json
      {
        id: @id,
        name: @name,
        image_url: @image_url
      }
    end
  end
end

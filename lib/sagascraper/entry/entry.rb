module SagaScraper
  class Item
  end

  class Equipment
    attr_accessor :id, :name, :image_url, :wearable_by,
      :requirements, :stats, :dropped_by, :obtained_from, :remarks

    def initialize
      @id
      @name
      @image_url
      @wearable_by
      @requirements
      @stats
      @dropped_by
      @obtained_from
      @remarks
    end

    def to_json
      {
        id:             @id,
        name:           @name,
        image_url:      @image_url,
        wearable_by:    @wearable_by,
        requirements:   @requirements,
        stats:          @stats,
        dropped_by:     @dropped_by,
        obtained_from:  @obtained_from,
        remarks:        @remarks
      }
    end
  end
end
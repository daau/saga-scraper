module SagaScraper
  class Equipment
    attr_accessor :id, :name, :image_url, :wearable_by, :requirements, :stats,
      :dropped_by, :obtained_from, :remarks

    def initialize
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
  end
end
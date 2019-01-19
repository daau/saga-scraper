class EquipmentCrawler
  attr_accessor :element
  
  def initialize(element)
    @element = element
  end

  def get_data
    @id = get_id
    @name = get_name
    @image_url = ROOT_URL + get_relative_image_url
    
    if @element.css("tr").count > 6 || @element.css("tr").count < 5
      raise InvalidTableError, "Invalid number of rows! (there were #{@element.css("tr").count} rows)"
    end
    
    puts @name.white
  end

  def get_id
    @element.attributes["id"].value
  end

  def get_name
    @element.css("tr")[0].children[3].children[1].children[0].text
  end

  def get_relative_image_url
    @element.children[1].children[1].children[1].children[1].attributes["src"].value
  end  
end
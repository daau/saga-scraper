require "awesome_print"

module SagaScraper
  class Display
    def self.print_header(header)
      puts ("="*25).red
      puts header.red
      puts ("="*25).red
    end

    def self.print_subheader(subheader)
      puts subheader.red
    end
  end
end
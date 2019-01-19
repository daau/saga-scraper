require "awesome_print"

module SagaScraper
  class Display
    def self.header(header)
      puts ("=" * 25).red
      puts header.red
      puts ("=" * 25).red
    end

    def self.subheader(subheader)
      puts subheader.red
    end
  end
end

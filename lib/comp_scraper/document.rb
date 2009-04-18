module CompScraper
  class Document
    class << self
      def fetch(url)
        Net::HTTP.get URI.parse(url)
      end
      
      def fetch_and_tidy(url)
        Tidy.open { |tidy| tidy.clean fetch(url) }
      end
    end
  end
end
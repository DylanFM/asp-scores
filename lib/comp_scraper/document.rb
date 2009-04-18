module CompScraper
  class Document
    class << self
      def fetch(url)
        Net::HTTP.get URI.parse(url)
      end
    end
  end
end
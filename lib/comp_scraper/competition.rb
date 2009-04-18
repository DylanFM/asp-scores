module CompScraper
  class Competition

    attr_reader :base_url

    def initialize(base_url)
      @base_url = base_url
    end
    
    def fetch_heat_data_for_round(round_number)
      {}
    end

  end
end

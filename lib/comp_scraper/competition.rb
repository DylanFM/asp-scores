module CompScraper
  class Competition

    attr_reader :base_url

    def initialize(base_url)
      @base_url = base_url
    end
    
    def fetch_heat_data_for_round(round_number)
      document = CompScraper::Document.fetch("#{base_url}mr#{round_number}.asp")
      CompScraper::RoundHeats.fetch_data(document)
    end
    
    def fetch_wave_scores_for_heat(round_number, heat_number)
      heat_number = "0#{heat_number}" if heat_number < 10
      document = CompScraper::Document.fetch_and_tidy("#{base_url}mr#{round_number}sc#{heat_number}.asp?rLingua=")
      CompScraper::HeatWaveScores.fetch_data(document)
    end

  end
end

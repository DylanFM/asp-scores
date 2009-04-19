module CompScraper
  class Heat
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :number, Integer,  :nullable => false
    
    belongs_to :round
    
    has n, :competitors
    
    def save_wave_scores
      data = fetch_wave_scores
      save_competitor_diffs(data)
    end
    
    private
      def fetch_wave_scores
        heat_number = "0#{self.number}" if self.number < 10
        document = CompScraper::Document.fetch_and_tidy("#{self.round.competition.base_url}mr#{self.round.number}sc#{heat_number}.asp?rLingua=")
        CompScraper::HeatWaveScores.fetch_data(document)
      end
    
      def save_competitor_diffs(data)
        data[:top_two_waves].each do |competitor|
          c = self.competitors.first(:name => competitor[:name])
          c.attributes = {
            :diff_status => competitor[:diff][:status],
            :diff_amount => competitor[:diff][:amount]
          }
          c.save
        end
      end
    
  end
end
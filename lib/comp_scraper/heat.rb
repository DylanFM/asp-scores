module CompScraper
  class Heat
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :number, Integer,  :nullable => false
    
    belongs_to :round
    
    has n, :competitors
    has n, :judges
    
    def save_wave_scores
      data = fetch_wave_scores
      save_competitor_diffs(data)
      competitors = self.competitors.all
      create_judges(data[:wave_scores][:judges])
      data[:wave_scores][:scores].each do |scores|
        surname = scores[:name].split('.').last
        competitor = competitors.detect { |c| c.name =~ /#{surname}$/i }
        next unless competitor
        competitor.waves = scores[:waves].collect do |wave|
          w = Wave.create(
            :average => wave[:avg],
            :inteference => wave[:inteference]
          )
          wave[:scores].each_with_index do |score, k|
            judge = self.judges.first(:initials => data[:wave_scores][:judges][k])
            w.scores.build(:amount => score, :judge => judge)
          end
          w
        end
        competitor.save
      end
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
      
      def create_judges(judges)
        judges.each do |judge|
          j = self.judges.build(:initials => judge)
          j.save
        end
      end

  end
end
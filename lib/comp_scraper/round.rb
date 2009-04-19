module CompScraper
  class Round
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :name,   String
    property :number, Integer
    
    belongs_to :competition
    
    has n, :heats
    
    def save_heat_data
      self.heats = fetch_heat_data.collect do |heat|
        h = Heat.create(:number => heat[:heat_number])
        h.competitors = heat[:competitors].collect do |competitor|
          Competitor.create(
            :place => competitor[:place],
            :points => competitor[:points],
            :singlet_colour => competitor[:singlet_colour],
            :name => competitor[:name],
            :home_country => competitor[:home_country]
          )
        end
        h
      end
      self.save
    end
    
    private
      def fetch_heat_data
        document = CompScraper::Document.fetch("#{competition.base_url}mr#{number}.asp")
        CompScraper::RoundHeats.fetch_data(document)
      end
    
  end
end
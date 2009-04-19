module CompScraper
  class Round
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :name,   String
    property :number, Integer
    
    belongs_to :competition
    
    has n, :heats
    
    attr_reader :heat_data
    
    def fetch_heat_data
      document = CompScraper::Document.fetch("#{competition.base_url}mr#{number}.asp")
      @heat_data = CompScraper::RoundHeats.fetch_data(document)
    end
    
    def save_heat_data
      fetch_heat_data if heat_data.nil?
      self.heats = heat_data.collect do |heat|
        Heat.create(:number => heat[:heat_number])
      end
      self.save
    end
    
  end
end
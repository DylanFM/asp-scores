module CompScraper
  class Round
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :name,   String
    property :number, Integer
    
    belongs_to :competition
    
    attr_reader :heat_data
    
    def fetch_heat_data
      document = CompScraper::Document.fetch("#{competition.base_url}mr#{number}.asp")
      @heat_data = CompScraper::RoundHeats.fetch_data(document)
    end
    
  end
end
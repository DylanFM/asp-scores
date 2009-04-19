module CompScraper
  class Heat
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :number, Integer,  :nullable => false
    
    belongs_to :round
    
    has n, :competitors
    
  end
end
module CompScraper
  class Competition
    include DataMapper::Resource
    
    property :id,       Integer,  :serial => true
    property :base_url, String,   :nullable => false
    property :name,     String,   :nullable => false
    
    has n, :rounds
    has n, :heats, :through => :rounds

  end
end

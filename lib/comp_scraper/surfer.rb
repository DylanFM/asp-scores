module CompScraper
  class Surfer
    include DataMapper::Resource
    
    property :id,           Integer,  :serial => true
    property :name,         String,   :nullable => false
    property :home_country, String
    
    has n, :competitors
    
  end
end
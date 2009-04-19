module CompScraper
  class Wave
    include DataMapper::Resource
    
    property :id,           Integer,  :serial => true
    property :average,      Float
    property :inteference,  Boolean,  :default => false
    
    belongs_to :competitor
    
    has n, :scores
    
  end
end
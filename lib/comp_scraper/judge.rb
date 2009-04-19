module CompScraper
  class Judge
    include DataMapper::Resource
    
    property :id,       Integer,  :serial => true
    property :initials, String,   :nullable => false
    
    belongs_to :heat
    
    has n, :scores
    
  end
end
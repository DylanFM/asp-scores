module CompScraper
  class Score
    include DataMapper::Resource
    
    property :id,     Integer,  :serial => true
    property :amount, Float,    :nullable => false
    
    belongs_to :wave
    
  end
end
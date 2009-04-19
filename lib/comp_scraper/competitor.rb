module CompScraper
  class Competitor
    include DataMapper::Resource
    
    property :id,             Integer,  :serial => true
    property :name,           String,   :nullable => false
    property :place,          Integer,  :nullable => false
    property :points,         Float,    :nullable => false
    property :home_country,   String
    property :singlet_colour, String
    
    belongs_to :heat
    
  end
end
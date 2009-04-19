module CompScraper
  class Competitor
    include DataMapper::Resource
    
    property :id,             Integer,  :serial => true
    property :name,           String,   :nullable => false
    property :place,          Integer,  :nullable => false
    property :points,         Float,    :nullable => false
    property :home_country,   String
    property :singlet_colour, String
    property :diff_status,    String
    property :diff_amount,    Float
    
    belongs_to :heat
    
    has n, :waves, :class_name => 'Wave'
    has n, :scores, :through => :waves
    
  end
end
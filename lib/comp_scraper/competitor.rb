module CompScraper
  class Competitor
    include DataMapper::Resource
    
    property :id,             Integer,  :serial => true
    property :place,          Integer,  :nullable => false
    property :points,         Float,    :nullable => false
    property :singlet_colour, String
    property :diff_status,    String
    property :diff_amount,    Float
    
    belongs_to :heat
    belongs_to :surfer
    
    has n, :waves, :class_name => 'Wave'
    has n, :scores, :through => :waves
    
  end
end
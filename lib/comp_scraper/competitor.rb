module CompScraper
  class Competitor
    include DataMapper::Resource

    property :id,             Integer,  :serial => true
    property :place,          Integer,  :nullable => false, :index => true
    property :points,         Float,    :nullable => false
    property :singlet_colour, String
    property :diff_status,    String
    property :diff_amount,    Float
    property :heat_id,        Integer,  :index => true
    property :surfer_id,      Integer,  :index => true

    belongs_to :heat
    belongs_to :surfer

    has n, :waves, :class_name => 'Wave'
    has n, :scores, :through => :waves

    # Returns whether the competitor came last in a heat
    def last?
      self.heat.competitors.all.size == self.place
    end

  end
end
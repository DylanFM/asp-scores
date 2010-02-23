module CompScraper
  class Competitor
    include DataMapper::Resource

    property :id,             Serial
    property :place,          Integer,  :nullable => false, :index => true
    property :points,         Float,    :nullable => false
    property :singlet_colour, String
    property :diff_status,    String
    property :diff_amount,    Float
    property :heat_id,        Integer,  :index => true
    property :surfer_id,      Integer,  :index => true

    belongs_to :heat
    belongs_to :surfer

    has n, :waves, :model => 'Wave'
    has n, :scores, :through => :waves

    default_scope(:default).update(:order => [:place.asc])

    def ordered_waves
      repository do
        waves = self.waves.all
      end
      waves
    end

    # Returns whether the competitor came last in a heat
    def last?
      self.heat.competitors.all.size == self.place
    end

  end
end
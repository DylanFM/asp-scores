module CompScraper
  class Judge
    include DataMapper::Resource

    property :id,       Integer,  :serial => true
    property :initials, String,   :nullable => false, :index => true
    property :heat_id,  Integer,  :index => true

    belongs_to :heat

    has n, :scores

  end
end
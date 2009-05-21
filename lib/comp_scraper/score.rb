module CompScraper
  class Score
    include DataMapper::Resource

    property :id,       Integer,  :serial => true
    property :amount,   Float,    :nullable => false
    property :wave_id,  Integer,  :index => true
    property :judge_id, Integer,  :index => true

    belongs_to :wave
    belongs_to :judge

  end
end
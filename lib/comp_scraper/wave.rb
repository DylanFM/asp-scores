module CompScraper
  class Wave
    include DataMapper::Resource

    property :id,             Integer,  :serial => true
    property :average,        Float
    property :inteference,    Boolean,  :default => false
    property :competitor_id,  Integer,  :index => true

    belongs_to :competitor

    has n, :scores

    def scores_with_judge
      self.scores.all.inject([]) do |scores,score|
        scores << {
          :amount => score.amount,
          :judge_initials => score.judge.initials
        }
        scores
      end
    end

  end
end
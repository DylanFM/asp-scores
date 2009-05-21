module CompScraper
  class Competition
    include DataMapper::Resource

    property :id,       Integer,  :serial => true
    property :base_url, String,   :nullable => false
    property :name,     String,   :nullable => false

    has n, :rounds
    has n, :heats, :through => :rounds

    def competition_rounds
      repository do
        rounds = self.rounds.all
      end
      rounds
    end

    def save_comp_data
      # Men's and women's
      %w( m f ).each do |gender|
        # All stages of the competition
        [1,2,3,'qf','sf','fi'].collect do |n|
          type = n.is_a?(String) ? {:name => n} : {:number => n}
          # Make a new round
          round = self.rounds.build(type.merge(:gender => gender))
          # Get the data for the round
          round.save_heat_data
          # Save comp
          self.save
        end
      end
    end

  end
end

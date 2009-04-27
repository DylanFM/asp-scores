require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe CompScraper do
  describe "competition" do
    
    before do
      @url = 'http://www.beachbyte.com/live09/rcp09/'
      FakeWeb.register_uri("#{@url}mr1.asp", :file => File.join(SPEC_DIR, 'supports', 'round-heat.html'))
      FakeWeb.register_uri("#{@url}fr1.asp", :file => File.join(SPEC_DIR, 'supports', 'female-round-1.html'))
      FakeWeb.register_uri("#{@url}mfi.asp", :file => File.join(SPEC_DIR, 'supports', 'final.html'))
      FakeWeb.register_uri("#{@url}mfisc01.asp?rLingua=", :file => File.join(SPEC_DIR, 'supports', 'final-heat.html'))
      (1..16).each do |i|
        padded_i =  i < 10 ? "0#{i}" : i.to_s
        FakeWeb.register_uri("#{@url}mr1sc#{padded_i}.asp?rLingua=", :file => File.join(SPEC_DIR, 'supports', "heat-#{i}.html"))
      end
      (1..6).each do |i|
        padded_i =  i < 10 ? "0#{i}" : i.to_s
        FakeWeb.register_uri("#{@url}fr1sc#{padded_i}.asp?rLingua=", :file => File.join(SPEC_DIR, 'supports', "f-heat-#{i}.html"))
      end
      
      @name = 'Rip Curl Pro'
      
      @comp = CompScraper::Competition.new
      @comp.attributes = {
        :base_url => @url,
        :name => @name
      }
      @comp.save
      @final = @comp.rounds.build(:name => 'fi', :gender => 'm')
      @final.save_heat_data
      @comp.save
    end
    
    it "should have a base url" do
      @comp.base_url.should == @url
    end
    
    it "should have a name" do
      @comp.name.should == @name
    end
    
    it "should get women's first round's heats data" do
      round = @comp.rounds.build(:number => 1, :gender => 'f')
      round.save_heat_data
      round.heats.size.should == 6
      @comp.save
    end
    
    it "should get men's first round's heats data" do
      round = @comp.rounds.build(:number => 1, :gender => 'm')
      round.save_heat_data
      round.heats.size.should == 16
      @comp.save
    end
    
    it "should get a men's final's data" do
      @final.heats.size.should == 1
      heat = @final.heats.first
      competitors = heat.competitors.all(:order => [:place.asc])
      competitors.size.should == 2
      winner = competitors.first
      loser = competitors.last
      winner.surfer.name.should == 'Joel Parkinson'
      loser.surfer.name.should == 'Adam Robertson'
      winner.surfer.home_country.should == 'AUS'
      loser.surfer.home_country.should == 'AUS'
      winner.singlet_colour.should == 'yellow'
      loser.singlet_colour.should == 'blue'
      winner.points.should == 17.4
      loser.points.should == 13.37
      winner.diff_status.should == 'Win by'
      winner.diff_amount.should == 4.0
      loser.diff_status.should == 'Comb.'
      loser.diff_amount.should == 17.41
      winner.waves.size.should == 6
      loser.waves.size.should == 5
      winnerscores = winner.waves.all.collect do |w|
        [w.average, w.inteference] << w.scores.all.collect { |s| s.amount }
      end
      winnerscores.should == [
        [6.33,false,[6.0,6.0,6.5,6.5,7.0]],
        [7.83,false,[7.0,8.0,8.0,7.5,8.0]],
        [9.57,false,[9.5,9.8,9.5,9.5,9.7]],
        [1.0,false,[1.0,1.0,1.0,1.0,1.2]],
        [1.4,false,[1.2,1.5,1.2,1.5,1.5]],
        [0.4,false,[0.2,0.5,0.5,0.7,0.2]]
      ]
      loserscores = loser.waves.all.collect do |w|
        [w.average, w.inteference] << w.scores.all.collect { |s| s.amount }
      end
      loserscores.should == [
        [6.5,false,[6.5,6.5,7.0,6.0,6.5]],
        [4.17,false,[4.0,4.5,5.0,4.0,4.0]],
        [5.6,false,[5.0,5.5,6.0,5.8,5.5]],
        [6.87,false,[6.8,7.5,6.2,7.0,6.8]],
        [2.77,false,[2.5,3.0,2.5,3.0,2.8]]
      ]
      @comp.save
    end
    
  end
end
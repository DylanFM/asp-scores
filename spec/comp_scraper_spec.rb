require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe CompScraper do
  describe "competition" do
    
    before do
      @url = 'http://www.beachbyte.com/live09/rcp09/'
      FakeWeb.register_uri("#{@url}mr1.asp", :file => File.join(SPEC_DIR, 'supports', 'round-heat.html'))
      FakeWeb.register_uri("#{@url}mr1sc04.asp?rLingua=", :file => File.join(SPEC_DIR, 'supports', 'heat-scores.html'))
      
      @name = 'Rip Curl Pro'
      
      @comp = CompScraper::Competition.new
      @comp.attributes = {
        :base_url => @url,
        :name => @name
      }
      @comp.save!
    end
    
    it "should have a base url" do
      @comp.base_url.should == @url
    end
    
    it "should have a name" do
      @comp.name.should == @name
    end
    
    it "should get a round's heats data" do
      round = @comp.rounds.build(:number => 1)
      round.fetch_heat_data
      round.heat_data.should be_instance_of(Array)
    end
    
    it "should get a heat's wave scores" do
      data = @comp.fetch_wave_scores_for_heat(1,4)
      data.should be_instance_of(Hash)
    end
    
  end
end
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe CompScraper do
  describe "competition" do
    
    before do
      @url = 'http://www.beachbyte.com/live09/rcp09/'
      FakeWeb.register_uri("#{@url}mr1.asp", :file => File.join(SPEC_DIR, 'supports', 'round-heat.html'))
      FakeWeb.register_uri("#{@url}mfi.asp", :file => File.join(SPEC_DIR, 'supports', 'final.html'))
      (1..9).each do |i|
        FakeWeb.register_uri("#{@url}mr1sc0#{i}.asp?rLingua=", :file => File.join(SPEC_DIR, 'supports', "heat-#{i}.html"))
      end
      
      @name = 'Rip Curl Pro'
      
      @comp = CompScraper::Competition.new
      @comp.attributes = {
        :base_url => @url,
        :name => @name
      }
      @comp.save
    end
    
    it "should have a base url" do
      @comp.base_url.should be @url
    end
    
    it "should have a name" do
      @comp.name.should be @name
    end
    
    it "should get a round's heats data" do
      round = @comp.rounds.build(:number => 1)
      round.save_heat_data
      round.heats.size.should be 9
      @comp.save
    end
    
    it "should get a final's heat data" do
      final = @comp.rounds.build(:name => 'fi')
      final.save_heat_data
      final.heats.size.should be 1
      @comp.save
    end
    
  end
end
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe CompScraper do
  describe "competition" do
    
    before do
      @url = 'http://www.beachbyte.com/live09/rcp09/'
      FakeWeb.register_uri("#{@url}mr1.asp", :file => File.join(SPEC_DIR, 'supports', 'round-heat.html'))
      
      @comp = CompScraper::Competition.new(@url)
    end
    
    it "should have a base url" do
      @comp.base_url.should == @url
    end
    
    it "should get a round's heats data" do
      data = @comp.fetch_heat_data_for_round(1)
      data.should be_instance_of(Array)
    end
    
  end
end
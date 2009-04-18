require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe CompScraper do
  describe "competition" do
    
    before(:each) do
      @url = 'http://www.beachbyte.com/live09/rcp09/'
      @comp = CompScraper::Competition.new(@url)
    end
    
    it "should have a base url" do
      @comp.base_url.should == @url
    end
    
    it "should get a round's heats page" do
      @comp.fetch_heat_data_for_round(1).should be_instance_of(Hash)
    end
    
  end
end
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe CompScraper do
  describe "competition" do
    
    it "should have a base url" do
      url = 'http://www.beachbyte.com/live09/rcp09/'
      comp = CompScraper::Competition.new(url)
      comp.base_url.should == url
    end
    
  end
end
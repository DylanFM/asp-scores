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
        padded_i = "0#{i}" if i < 10
        FakeWeb.register_uri("#{@url}mr1sc#{padded_i}.asp?rLingua=", :file => File.join(SPEC_DIR, 'supports', "heat-#{i}.html"))
      end
      (1..6).each do |i|
        padded_i = "0#{i}" if i < 10
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
      @comp.base_url.should be @url
    end
    
    it "should have a name" do
      @comp.name.should be @name
    end
    
    it "should get women's first round's heats data" do
      round = @comp.rounds.build(:number => 1, :gender => 'f')
      round.save_heat_data
      round.heats.size.should be 6
      @comp.save
    end
    
    it "should get men's first round's heats data" do
      round = @comp.rounds.build(:number => 1, :gender => 'm')
      round.save_heat_data
      round.heats.size.should be 16
      @comp.save
    end
    
    it "should get a men's final's data" do
      @final.heats.size.should be 1
      @comp.save
    end
    
  end
end
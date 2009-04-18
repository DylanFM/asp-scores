#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'

def doc
  # Nokogiri::HTML Net::HTTP.get(URI.parse('http://www.beachbyte.com/live09/rcp09/mr1.asp'))
  File.open('round-heat-sample.html', 'r') { |f| Nokogiri::HTML f.read }
end

# Return the raw heat data from the page, we'll tidy it up later on
def get_heats(page)
  page.css('body > center > table table').inject(Array.new) do |heats, heat|
    #It seems like the tables we want have a cellpadding of 5, which seems unique too
    next heats unless heat.get_attribute('cellpadding').to_i == 5
    heats << heat.children.css('td').collect { |cell| cell.content.strip }
  end
end

def competitor_info(heat)
  competitor_info, competitors = heat[6..-1], []
  until competitor_info.empty? || competitor_info.size < 5
    competitor = competitor_info.slice!(0..4)
    competitors << {
          :singlet_colour => competitor[0].gsub(/[\\nr]/,''),
          :place => competitor[1].to_i,
          :points => competitor[2].to_f,
          :name => competitor[3],
          :home_country => competitor[4]
        }
  end
  competitors
end

# Get the raw heat data and make it more usable
def process_heat_info(data)
  data.inject(Array.new) do |heats, heat|
    next heats unless heat[0] =~ /(Heat # (\d+)).+(Round (\d+))/m
    match = Regexp.last_match
    heats << {
      :heat_number => match[2],
      :round_number => match[4],
      :competitors => competitor_info(heat)
    }
  end
end

begin
  p process_heat_info(get_heats(doc))
rescue Exception => e
  puts e
end
# >> [{:heat_number=>"1", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"David Weare", :place=>1, :points=>13.0, :home_country=>"ZAF"}, {:singlet_colour=>"Blue", :name=>"Nathaniel Curran", :place=>2, :points=>11.16, :home_country=>"USA"}]}, {:heat_number=>"2", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Roy Powers", :place=>2, :points=>6.26, :home_country=>"HAW"}, {:singlet_colour=>"Blue", :name=>"Michel Bourez", :place=>1, :points=>12.33, :home_country=>"PFY"}]}, {:heat_number=>"3", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Heitor Alves", :place=>2, :points=>6.6, :home_country=>"BRA"}, {:singlet_colour=>"Blue", :name=>"Jay Thompson", :place=>1, :points=>14.66, :home_country=>"AUS"}]}, {:heat_number=>"4", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Taylor Knox", :place=>1, :points=>15.84, :home_country=>"USA"}, {:singlet_colour=>"Blue", :name=>"Phillip MacDonald", :place=>2, :points=>10.16, :home_country=>"AUS"}]}, {:heat_number=>"5", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Dayyan Neve", :place=>1, :points=>14.0, :home_country=>"AUS"}, {:singlet_colour=>"Blue", :name=>"Marlon Lipke", :place=>2, :points=>7.6, :home_country=>"DEU"}]}, {:heat_number=>"6", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Kieren Perrow", :place=>1, :points=>12.5, :home_country=>"AUS"}, {:singlet_colour=>"Blue", :name=>"Aritz Aranburu", :place=>2, :points=>12.23, :home_country=>"EUK"}]}, {:heat_number=>"7", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Jihad Khodr", :place=>1, :points=>10.83, :home_country=>"BRA"}, {:singlet_colour=>"Blue", :name=>"Patrick Gudauskas", :place=>2, :points=>8.5, :home_country=>"USA"}]}, {:heat_number=>"8", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Dane Reynolds", :place=>2, :points=>10.5, :home_country=>"USA"}, {:singlet_colour=>"Blue", :name=>"Owen Wright", :place=>1, :points=>13.5, :home_country=>"AUS"}]}, {:heat_number=>"9", :round_number=>"1", :competitors=>[{:singlet_colour=>"Yellow", :name=>"Jordy Smith", :place=>1, :points=>18.7, :home_country=>"ZAF"}, {:singlet_colour=>"Blue", :name=>"Matt Wilkinson", :place=>2, :points=>11.66, :home_country=>"AUS"}]}]

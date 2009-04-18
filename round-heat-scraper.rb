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

# Return nice data from heats page
def round_heats_data
  raw_heats_data = get_heats(doc)
  process_heat_info(raw_heats_data)
end

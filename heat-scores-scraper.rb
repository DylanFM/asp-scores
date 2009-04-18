#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'

def doc
  # Nokogiri::HTML Net::HTTP.get(URI.parse('http://www.beachbyte.com/live09/rcp09/mr1sc01.asp?rLingua='))
  File.open('heat-scores-sample.html', 'r') { |f| Nokogiri::HTML f.read }
end

# Return the info from the top two waves section at the beginning of the page
def get_top_two_waves(page)
  page.css('body > center > table > tr > td > center > table td[align="center"] > table tr').inject(Array.new) do |competitors, competitor|
    competitors << competitor.children.css('td.BodyL').collect { |cell| cell.content.strip }
  end
end

begin
  p get_top_two_waves(doc)
rescue Exception => e
  puts e
end

# >> [[], []]

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
def get_top_two_waves_data(page)
  page.css('body > center > table > tr > td > center > table td[align="center"] > table tr').collect do |competitor|
    competitor.css('td.BodyL').collect { |cell| cell.content.strip }
  end
end

def get_top_two_waves(page)
  get_top_two_waves_data(page).collect do |competitor|
    next unless competitor.join('|') =~ /^((\d)\w{2})\|([\w\s]+)(\((\w+)\s*\))\|(\d+\.[\w\d]{2})p,\s?(Win by|Needs|Comb.)\s(\d+\.[\w\d]{2})/i
    match = Regexp.last_match
    {
      :place => match[2].to_i,
      :name => match[3].strip,
      :from => match[5],
      :heat_total => match[6].to_f,
      :diff => {
        :status => match[7],
        :amount => match[8].to_f
      }
    }
  end
end

begin
  pp get_top_two_waves(doc)
rescue Exception => e
  puts e
end

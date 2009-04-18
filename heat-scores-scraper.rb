#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'

def doc
  # Nokogiri::HTML Net::HTTP.get(URI.parse('http://www.beachbyte.com/live09/rcp09/mr1sc01.asp?rLingua='))
  File.open('heat-scores-sample.html', 'r') { |f| Nokogiri::HTML f.read }
end



begin
  p doc
rescue Exception => e
  puts e
end

# >>
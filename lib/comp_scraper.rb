require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'tidy'

Dir.glob(File.join(File.dirname(__FILE__), "comp_scraper", "*.rb")).each { |f| require f }

Tidy.path =  '/usr/lib/libtidy.dylib'

module CompScraper
  
end
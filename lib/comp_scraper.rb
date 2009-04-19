require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'tidy'
require 'data_mapper'

require File.join(File.dirname(__FILE__), "..", "config", "environment.rb")

Dir.glob(File.join(File.dirname(__FILE__), "comp_scraper", "*.rb")).each { |f| require f }

Tidy.path = TIDY_PATH

module CompScraper
  
end
require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'tidy'
require 'data_mapper'
require 'dm-validations'

# Load config
require File.join(File.dirname(__FILE__), "..", "config", "environment.rb")

# Setup database connection
DataMapper.setup(:default, DATABASE_OPTIONS)

# Load app files
Dir.glob(File.join(File.dirname(__FILE__), "comp_scraper", "*.rb")).each { |f| require f }

# Set the Tidy path for Ruby HTML tidy gem
Tidy.path = TIDY_PATH

module CompScraper

  ROUNDS = {
    :"qf" => 'Quarter-final',
    :"sf" => 'Semi-final',
    :"fi" => 'Final'
  }

end
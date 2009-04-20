$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'sinatra'
require 'erb'
require 'comp_scraper'

get '/' do
  rcp = CompScraper::Competition.first(:name => 'Rip Curl Pro Bells Beach 2009')
  rcp.name
end

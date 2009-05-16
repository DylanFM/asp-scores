$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'comp_scraper'
require 'sinatra'
require 'erb'

get '/' do
  @rcp = CompScraper::Competition.first(:name => 'Rip Curl Pro Bells Beach 2009')
  erb :index
end

get '/competitors/:competitor_id' do
  @competitor = CompScraper::Competitor.get(params[:competitor_id].to_i)
  erb :'competitors.json', :layout => false
end

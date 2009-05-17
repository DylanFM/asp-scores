$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'comp_scraper'
require 'sinatra'
require 'erb'

get '/' do
  @rcp = CompScraper::Competition.first(:name => 'Rip Curl Pro Bells Beach 2009')
  erb :index
end

get '/competitors/:competitor_id/wave_averages' do
  @competitor = CompScraper::Competitor.get(params[:competitor_id].to_i)
  erb :'competitors/wave_averages.json', :layout => false
end

get '/waves/:wave_id' do
  @wave = CompScraper::Wave.get(params[:wave_id].to_i)
  erb :'competitors/waves/show', :layout => false
end

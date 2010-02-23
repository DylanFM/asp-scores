$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'comp_scraper'
require 'sinatra'
require 'erb'

get '/:id' do
  @rcp = CompScraper::Competition.get(params[:id])
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

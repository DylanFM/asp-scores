$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'comp_scraper'
require 'pp'

# Make a new competition
rcp = CompScraper::Competition.create(
    :base_url => 'http://www.beachbyte.com/live09/rcp09/', # !> method redefined; discarding old to_hash
    :name => "Rip Curl Pro Bells Beach 2009"
  )

rcp.save_comp_data # !> `&' interpreted as argument prefix
# 
# puts rcp.name
# rcp.rounds.all.each do |round| # !> method redefined; discarding old classify
#   puts "#{round.gender == 'f' ? "Women's" : "Men's"} #{round}:"
#   round.heats.all.each do |heat|
#     winner = heat.competitors.first(:place => 1)
#     loser = heat.competitors.first(:place => 2)
#     puts "\tHeat #{heat.number} - #{winner.surfer.name} beat #{loser.surfer.name} who needed #{loser.diff_amount} points"
#   end
# end

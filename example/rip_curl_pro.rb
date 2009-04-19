$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'comp_scraper'
require 'pp'

# Make a new competition
rcp = CompScraper::Competition.create(
    :base_url => 'http://www.beachbyte.com/live09/rcp09/',
    :name => "Rip Curl Pro Bells Beach 2009"
  )

# First 3 rounds # !> `&' interpreted as argument prefix
(1..3).collect do |n|
  # Make a new round
  round = rcp.rounds.build(:number => n)
  # Get the data for the round
  round.save_heat_data
  # Save comp
  rcp.save
end

puts rcp.name
rcp.rounds.all.each do |round|
  puts "Round #{round.number}:"
  round.heats.all.each do |heat|
    winner = heat.competitors.first(:place => 1)
    loser = heat.competitors.first(:place => 2)
    puts "\tHeat #{heat.number} - #{winner.surfer.name} beat #{loser.surfer.name} who needed #{loser.diff_amount} points"
  end
end

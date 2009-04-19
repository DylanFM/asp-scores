#ASP world tour comp data
I'm interested in doing something with all the competition data from the ASP (Association of Surfing Professionals) world tour. Lots of things that can be done. How exciting!

##Example
This is pulled from [the Rip Curl Pro file in examples/](http://github.com/DylanFM/asp-scores/blob/e8d41659d8a1846a7c009b8824d5e974ae76c9a4/example/rip_curl_pro.rb).

		# Make a new competition
		rcp = CompScraper::Competition.create(
		    :base_url => 'http://www.beachbyte.com/live09/rcp09/',
		    :name => "Rip Curl Pro Bells Beach 2009"
		  )

		# First 3 rounds
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
		# >> Rip Curl Pro Bells Beach 2009
		# >> Round 1:
		# >> 	Heat 1 - David Weare beat Nathaniel Curran who needed 6.68 points
		# >> 	Heat 2 - Michel Bourez beat Roy Powers who needed 8.4 points
		# >> 	Heat 3 - Jay Thompson beat Heitor Alves who needed 14.67 points
		# >> 	Heat 4 - Taylor Knox beat Phillip MacDonald who needed 9.51 points
		# >> 	Heat 5 - Dayyan Neve beat Marlon Lipke who needed 14.0 points
		# >> 	Heat 6 - Kieren Perrow beat Aritz Aranburu who needed 5.27 points
		# >> 	Heat 7 - Jihad Khodr beat Patrick Gudauskas who needed 6.5 points
		# >> 	Heat 8 - Owen Wright beat Dane Reynolds who needed 6.68 points
		# >> 	Heat 9 - Jordy Smith beat Matt Wilkinson who needed 18.71 points
		# >> Round 2:
		# >> 	Heat 1 - CJ Hobgood beat Mick Campbell who needed 9.67 points
		# >> 	Heat 2 - Taylor Knox beat Chris Ward who needed 16.94 points
		# >> 	Heat 3 - Kai Otton beat Dayyan Neve who needed 6.18 points
		# >> 	Heat 4 - Joel Parkinson beat Michel Bourez who needed 16.77 points
		# >> 	Heat 5 - Mick Fanning beat Tiago Pires who needed 8.4 points
		# >> 	Heat 6 - Bobby Martinez beat Tim Boal who needed 16.41 points
		# >> 	Heat 7 - Jordy Smith beat Damien Hobgood who needed 5.84 points
		# >> 	Heat 8 - Owen Wright beat Kelly Slater who needed 7.67 points
		# >> 	Heat 9 - Adam Robertson beat Bede Durbidge who needed 7.94 points
		# >> Round 3:
		# >> 	Heat 1 - CJ Hobgood beat Taylor Knox who needed 8.5 points
		# >> 	Heat 2 - Joel Parkinson beat Kai Otton who needed  points
		# >> 	Heat 3 - Mick Fanning beat Bobby Martinez who needed 14.27 points
		# >> 	Heat 4 - Jordy Smith beat Owen Wright who needed 9.67 points
		# >> 	Heat 5 - Adam Robertson beat Tom Whitaker who needed 8.67 points
		# >> 	Heat 6 - Kekoa Bacalso beat Drew Courtney who needed 17.35 points
		# >> 	Heat 7 - Kieren Perrow beat Jay Thompson who needed 7.5 points
		# >> 	Heat 8 - Fredrick Patacchia beat Dean Morrison who needed 17.58 points

##Here are some example URLS:
* [Heats in a round](http://www.beachbyte.com/live09/rcp09/mr1.asp) (_supported_)
* [Scores for a heat per judge per wave per surfer](http://www.beachbyte.com/live09/rcp09/mr1sc01.asp?rLingua=) (_suppported_)
* [Like a wave-by-wave log or transcript for a heat](http://www.beachbyte.com/live09/rcp09/mr1pf01.asp?rLingua=)

_The ones marked as supported can be parsed with this code._

I'd like to get each of these pages supported and to plonk everything into a database so we can have lotsa fun.

##Requirements
* Nokogiri
* Tidy (change the path in lib/comp_scraper.rb to your tidy installation)
* Datamapper
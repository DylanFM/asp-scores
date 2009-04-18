#ASP world tour comp data
I'm interested in doing something with all the competition data from the ASP (Association of Surfing Professionals) world tour. Lots of things that can be done. How exciting!

Have a look at this example of [getting some Rip Curl Pro 2009 data](http://github.com/DylanFM/asp-scores/blob/1892d97bb8644297519d5389c26e12a1ad36de8c/example/get_first_three_rounds_of_bells_comp.rb) and [here's another](http://github.com/DylanFM/asp-scores/blob/1892d97bb8644297519d5389c26e12a1ad36de8c/example/get_wave_scores_for_first_5_heats_of_round_1.rb).

##Here are some example URLS:
* [Heats in a round](http://www.beachbyte.com/live09/rcp09/mr1.asp) (_supported_)
* [Scores for a heat per judge per wave per surfer](http://www.beachbyte.com/live09/rcp09/mr1sc01.asp?rLingua=) (_suppported_)
* [Like a wave-by-wave log or transcript for a heat](http://www.beachbyte.com/live09/rcp09/mr1pf01.asp?rLingua=)

_The ones marked as supported can be parsed with this code._

I'd like to get each of these pages supported and to plonk everything into a database so we can have lotsa fun.

##Requirements
* Nokogiri
* Tidy (change the path in lib/comp_scraper.rb to your tidy installation)
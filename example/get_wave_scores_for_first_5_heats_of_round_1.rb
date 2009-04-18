$:<< File.join(File.dirname(__FILE__), '..', 'lib')

require 'comp_scraper'
require 'pp'

rip_curl_pro = CompScraper::Competition.new('http://www.beachbyte.com/live09/rcp09/')
round_one = (1..5).collect { |n| rip_curl_pro.fetch_wave_scores_for_heat(1,n) }

pp round_one
# >> [{:top_two_waves=>
# >>    [{:place=>1,
# >>      :from=>"ZAF",
# >>      :name=>"David Weare",
# >>      :heat_total=>13.0,
# >>      :diff=>{:status=>"Win by", :amount=>1.84}},
# >>     {:place=>2,
# >>      :from=>"USA",
# >>      :name=>"Nathaniel Curran",
# >>      :heat_total=>11.16,
# >>      :diff=>{:status=>"Needs", :amount=>6.68}}],
# >>   :wave_scores=>
# >>    {:scores=>
# >>      [{:waves=>
# >>         [{:scores=>[3.5, 2.5, 2.0, 2.5, 2.5], :avg=>2.5, :inteference=>false},
# >>          {:scores=>[6.0, 5.5, 5.5, 5.0, 5.5], :avg=>5.5, :inteference=>false},
# >>          {:scores=>[1.2, 1.0, 0.7, 0.5, 1.2], :avg=>0.97, :inteference=>false},
# >>          {:scores=>[3.0, 3.5, 2.5, 3.5, 3.0], :avg=>3.17, :inteference=>false},
# >>          {:scores=>[7.5, 7.5, 6.0, 7.5, 7.5], :avg=>7.5, :inteference=>false},
# >>          {:scores=>[0.5, 0.8, 0.5, 0.3, 0.8], :avg=>0.6, :inteference=>false}],
# >>        :name=>"D.Weare"},
# >>       {:waves=>
# >>         [{:scores=>[1.0, 0.5, 0.5, 0.5, 1.0], :avg=>0.67, :inteference=>false},
# >>          {:scores=>[1.5, 1.5, 1.5, 1.5, 1.5], :avg=>1.5, :inteference=>false},
# >>          {:scores=>[7.0, 6.5, 6.5, 6.0, 6.0], :avg=>6.33, :inteference=>false},
# >>          {:scores=>[5.0, 4.5, 4.0, 4.0, 4.0], :avg=>4.17, :inteference=>false},
# >>          {:scores=>[0.5, 0.5, 0.3, 0.3, 0.5], :avg=>0.43, :inteference=>false},
# >>          {:scores=>[5.5, 5.0, 4.5, 4.5, 5.0],
# >>           :avg=>4.83,
# >>           :inteference=>false}],
# >>        :name=>"N.Curran"}],
# >>     :judges=>["DS", "EB", "YS", "RP", "BL"]}},
# >>  {:top_two_waves=>
# >>    [{:place=>1,
# >>      :from=>"PFY",
# >>      :name=>"Michel Bourez",
# >>      :heat_total=>12.33,
# >>      :diff=>{:status=>"Win by", :amount=>6.0}},
# >>     {:place=>2,
# >>      :from=>"HAW",
# >>      :name=>"Roy Powers",
# >>      :heat_total=>6.26,
# >>      :diff=>{:status=>"Needs", :amount=>8.4}}],
# >>   :wave_scores=>
# >>    {:scores=>
# >>      [{:waves=>
# >>         [{:scores=>[2.5, 2.5, 2.0, 2.0, 2.5], :avg=>2.33, :inteference=>false},
# >>          {:scores=>[3.0, 2.0, 2.3, 2.5, 2.0], :avg=>2.27, :inteference=>false},
# >>          {:scores=>[1.5, 1.5, 1.7, 1.5, 1.5], :avg=>1.5, :inteference=>false},
# >>          {:scores=>[2.3, 1.7, 2.5, 1.8, 1.8], :avg=>1.97, :inteference=>false},
# >>          {:scores=>[3.8, 4.0, 3.7, 4.0, 5.0],
# >>           :avg=>3.93,
# >>           :inteference=>false}],
# >>        :name=>"R.Powers"},
# >>       {:waves=>
# >>         [{:scores=>[7.5, 7.5, 7.0, 7.0, 7.5], :avg=>7.33, :inteference=>false},
# >>          {:scores=>[2.7, 3.0, 2.5, 3.0, 3.5], :avg=>2.9, :inteference=>false},
# >>          {:scores=>[4.0, 4.5, 3.5, 3.5, 4.0], :avg=>3.83, :inteference=>false},
# >>          {:scores=>[1.2, 1.0, 1.0, 1.0, 1.0], :avg=>1.0, :inteference=>false},
# >>          {:scores=>[5.0, 5.0, 4.5, 5.0, 5.5], :avg=>5.0, :inteference=>false}],
# >>        :name=>"M.Bourez"}],
# >>     :judges=>["DS", "EB", "JK", "LP", "BL"]}},
# >>  {:top_two_waves=>
# >>    [{:place=>1,
# >>      :from=>"AUS",
# >>      :name=>"Jay Thompson",
# >>      :heat_total=>14.66,
# >>      :diff=>{:status=>"Win by", :amount=>8.0}},
# >>     {:place=>2,
# >>      :from=>"BRA",
# >>      :name=>"Heitor Alves",
# >>      :heat_total=>6.6,
# >>      :diff=>{:status=>"Comb.", :amount=>14.67}}],
# >>   :wave_scores=>
# >>    {:scores=>
# >>      [{:waves=>
# >>         [{:scores=>[4.0, 3.5, 4.5, 4.5, 4.5], :avg=>4.33, :inteference=>false},
# >>          {:scores=>[0.5, 0.8, 1.0, 1.0, 1.0], :avg=>0.93, :inteference=>false},
# >>          {:scores=>[1.0, 0.7, 1.2, 1.2, 0.8], :avg=>1.0, :inteference=>false},
# >>          {:scores=>[0.2, 0.2, 0.1, 0.2, 0.1], :avg=>0.17, :inteference=>false},
# >>          {:scores=>[0.7, 0.5, 0.5, 0.8, 1.0], :avg=>0.67, :inteference=>false},
# >>          {:scores=>[3.0, 2.0, 2.0, 2.5, 2.3],
# >>           :avg=>2.27,
# >>           :inteference=>false}],
# >>        :name=>"H.Alves"},
# >>       {:waves=>
# >>         [{:scores=>[8.0, 8.5, 9.0, 9.0, 9.0], :avg=>8.83, :inteference=>false},
# >>          {:scores=>[3.5, 2.0, 3.0, 3.5, 3.5], :avg=>3.33, :inteference=>false},
# >>          {:scores=>[2.7, 1.8, 1.7, 2.0, 2.5], :avg=>2.1, :inteference=>false},
# >>          {:scores=>[5.5, 5.0, 5.0, 5.0, 6.0], :avg=>5.17, :inteference=>false},
# >>          {:scores=>[6.5, 5.5, 6.0, 6.0, 5.5],
# >>           :avg=>5.83,
# >>           :inteference=>false}],
# >>        :name=>"J.Thompson"}],
# >>     :judges=>["DS", "RP", "JK", "LP", "YS"]}},
# >>  {:top_two_waves=>
# >>    [{:place=>1,
# >>      :from=>"USA",
# >>      :name=>"Taylor Knox",
# >>      :heat_total=>15.84,
# >>      :diff=>{:status=>"Win by", :amount=>5.68}},
# >>     nil],
# >>   :wave_scores=>
# >>    {:scores=>
# >>      [{:waves=>
# >>         [{:scores=>[2.0, 2.0, 1.8, 2.0, 2.0], :avg=>2.0, :inteference=>false},
# >>          {:scores=>[6.5, 6.0, 7.0, 7.0, 6.5], :avg=>6.67, :inteference=>false},
# >>          {:scores=>[9.5, 9.0, 9.0, 9.0, 9.5], :avg=>9.17, :inteference=>false},
# >>          {:scores=>[0.8, 1.0, 1.0, 1.2, 0.5],
# >>           :avg=>0.93,
# >>           :inteference=>false}],
# >>        :name=>"T.Knox"},
# >>       {:waves=>
# >>         [{:scores=>[3.0, 3.5, 4.0, 4.0, 4.0], :avg=>3.83, :inteference=>false},
# >>          {:scores=>[2.8, 2.5, 3.0, 3.0, 2.5], :avg=>2.77, :inteference=>false},
# >>          {:scores=>[1.0, 0.8, 1.0, 1.0, 1.0], :avg=>1.0, :inteference=>false},
# >>          {:scores=>[6.0, 6.5, 6.0, 6.5, 7.0],
# >>           :avg=>6.33,
# >>           :inteference=>false}],
# >>        :name=>"P.MacDonald"}],
# >>     :judges=>["BL", "RP", "JK", "EB", "YS"]}},
# >>  {:top_two_waves=>
# >>    [{:place=>1,
# >>      :from=>"AUS",
# >>      :name=>"Dayyan Neve",
# >>      :heat_total=>14.0,
# >>      :diff=>{:status=>"Win by", :amount=>6.4}},
# >>     {:place=>2,
# >>      :from=>"DEU",
# >>      :name=>"Marlon Lipke",
# >>      :heat_total=>7.6,
# >>      :diff=>{:status=>"Comb.", :amount=>14.0}}],
# >>   :wave_scores=>
# >>    {:scores=>
# >>      [{:waves=>
# >>         [{:scores=>[7.0, 7.0, 7.0, 6.5, 7.0], :avg=>7.0, :inteference=>false},
# >>          {:scores=>[7.5, 6.5, 6.0, 7.0, 7.5], :avg=>7.0, :inteference=>false},
# >>          {:scores=>[0.5, 0.5, 1.0, 0.5, 0.5], :avg=>0.5, :inteference=>false},
# >>          {:scores=>[3.0, 2.5, 2.0, 2.0, 3.0], :avg=>2.5, :inteference=>false},
# >>          {:scores=>[2.5, 2.7, 2.8, 2.5, 2.0], :avg=>2.57, :inteference=>false},
# >>          {:scores=>[5.5, 4.5, 5.0, 4.5, 5.5], :avg=>5.0, :inteference=>false},
# >>          {:scores=>[2.0, 2.0, 2.5, 2.2, 2.2], :avg=>2.13, :inteference=>false},
# >>          {:scores=>[0.3, 0.3, 0.2, 0.5, 0.2], :avg=>0.27, :inteference=>false},
# >>          {:scores=>[6.0, 5.0, 4.7, 5.0, 3.7], :avg=>4.9, :inteference=>false}],
# >>        :name=>"D.Neve"},
# >>       {:waves=>
# >>         [{:scores=>[4.0, 3.5, 3.5, 4.0, 3.5], :avg=>3.67, :inteference=>false},
# >>          {:scores=>[1.0, 1.5, 1.2, 0.5, 1.0], :avg=>1.07, :inteference=>false},
# >>          {:scores=>[2.8, 3.0, 3.3, 3.0, 3.2], :avg=>3.07, :inteference=>false},
# >>          {:scores=>[4.5, 3.8, 4.0, 3.5, 4.0], :avg=>3.93, :inteference=>false},
# >>          {:scores=>[0.8, 0.5, 1.0, 1.0, 0.5],
# >>           :avg=>0.77,
# >>           :inteference=>false}],
# >>        :name=>"M.Lipke"}],
# >>     :judges=>["BL", "LP", "DS", "EB", "YS"]}}]

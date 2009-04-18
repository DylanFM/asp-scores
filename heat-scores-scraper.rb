#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'

require 'pp'

def doc
  # Nokogiri::HTML Net::HTTP.get(URI.parse('http://www.beachbyte.com/live09/rcp09/mr1sc01.asp?rLingua='))
  File.open('heat-scores-sample.html', 'r') { |f| Nokogiri::HTML f.read }
end

# Return the raw info from the top two waves section at the beginning of the page
def get_top_two_waves_data(page)
  page.css('body > center > table > tr > td > center > table td[align="center"] > table tr').collect do |competitor|
    competitor.css('td.BodyL').collect { |cell| cell.content.strip }
  end
end

# Return the info of top two waves and heat summary in a hash
def get_top_two_waves(page)
  get_top_two_waves_data(page).collect do |competitor|
    next unless competitor.join('|') =~ /^((\d)\w{2})\|([\w\s]+)(\((\w+)\s*\))\|(\d+\.[\w\d]{2})p,\s?(Win by|Needs|Comb.)\s(\d+\.[\w\d]{2})/i
    match = Regexp.last_match
    {
      :place => match[2].to_i,
      :name => match[3].strip,
      :from => match[5],
      :heat_total => match[6].to_f,
      :diff => {
        :status => match[7],
        :amount => match[8].to_f
      }
    }
  end
end

# Return raw stripped data from the competitor's wave scores section of the page
def get_competitor_wave_scores_data(page)
  hash_template = {
    :judges => [],
    :scores => []
  }
  page.css('body > center > table > tr > td > center > table table[bordercolor="#D8DADF"]').inject(hash_template) do |data,table|
    if table['border'].to_i == 1
      data[:scores] << {
        :name => table.css('div[align="center"] > font').inner_text,
        :waves => []
      }
    end
    data
  end
end

# Return competitor's wave scores data in a hash
def get_competitor_wave_scores(page)
  get_competitor_wave_scores_data(page)
  
  # {
  #     :judges => [],
  #     :scores => [
  #       {
  #         :name => ,
  #         :waves => [
  #           {
  #             :inteference => ?,
  #             :average => ,
  #             :scores => {
  #               :JUDGE_NAME => ,
  #               :JUDGE_NAME => ,
  #               :JUDGE_NAME => ,
  #               :JUDGE_NAME => ....
  #             }
  #           }
  #         ]
  #       }
  #     ]
  #   }
end


begin
  data = {
    :top_two_waves => get_top_two_waves(doc),
    :wave_scores => get_competitor_wave_scores(doc)
  } 
  pp data
rescue Exception => e
  puts e
end

# >> {:wave_scores=>
# >>   {:judges=>[],
# >>    :scores=>[{:name=>"D.Weare", :waves=>[]}, {:name=>"N.Curran", :waves=>[]}]},
# >>  :top_two_waves=>
# >>   [{:name=>"David Weare",
# >>     :place=>1,
# >>     :from=>"ZAF",
# >>     :heat_total=>13.0,
# >>     :diff=>{:amount=>1.84, :status=>"Win by"}},
# >>    {:name=>"Nathaniel Curran",
# >>     :place=>2,
# >>     :from=>"USA",
# >>     :heat_total=>11.16,
# >>     :diff=>{:amount=>6.68, :status=>"Needs"}}]}

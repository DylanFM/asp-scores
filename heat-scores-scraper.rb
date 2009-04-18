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
def get_competitor_wave_scores(page)
  data, name = {:scores => []}, ''
  page.css('body > center > table > tr > td > center > table[bordercolor="#D8DADF"]').each do |table|
    competitor = name.empty? ? nil : name
    name = table.css('div[align="center"] > font').inner_text
    if name.empty? && !competitor.empty?
      data[:judges] = get_judges_from table unless data.has_key? :judges
      data[:scores].detect { |c| c[:name] == competitor }[:waves] = table.css('tr').collect do |row|
        next if row.css('td').size <= 2 || row.children.css('td.BodyC').size > 0
        cells = row.css('td.BodyL')
        avg = cells.detect { |c| !c.key?('align') }
        next if avg.nil?
        {
          :avg => avg.text.strip.to_f,
          :inteference => false,
          :scores => cells.collect { |cell| next unless cell['align'] == 'left'; cell.content.to_f }.compact!
        }
      end.compact
    else
      data[:scores] << {
        :name => name,
        :waves => []
      }
    end
  end
  data
end

# Just extract the judge names from the table
def get_judges_from(table)
  table.css('td.BodyC').collect do |judge|
    judge.text.strip
  end
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

# >> {:top_two_waves=>
# >>   [{:name=>"David Weare",
# >>     :place=>1,
# >>     :from=>"ZAF",
# >>     :heat_total=>13.0,
# >>     :diff=>{:amount=>1.84, :status=>"Win by"}},
# >>    {:name=>"Nathaniel Curran",
# >>     :place=>2,
# >>     :from=>"USA",
# >>     :heat_total=>11.16,
# >>     :diff=>{:amount=>6.68, :status=>"Needs"}}],
# >>  :wave_scores=>
# >>   {:judges=>["DS", "EB", "YS", "RP", "BL"],
# >>    :scores=>
# >>     [{:name=>"D.Weare",
# >>       :waves=>
# >>        [{:avg=>2.5, :scores=>[3.5, 2.5, 2.0, 2.5, 2.5], :inteference=>false},
# >>         {:avg=>5.5, :scores=>[6.0, 5.5, 5.5, 5.0, 5.5], :inteference=>false},
# >>         {:avg=>0.97, :scores=>[1.2, 1.0, 0.7, 0.5, 1.2], :inteference=>false},
# >>         {:avg=>3.17, :scores=>[3.0, 3.5, 2.5, 3.5, 3.0], :inteference=>false},
# >>         {:avg=>7.5, :scores=>[7.5, 7.5, 6.0, 7.5, 7.5], :inteference=>false},
# >>         {:avg=>0.6, :scores=>[0.5, 0.8, 0.5, 0.3, 0.8], :inteference=>false}]},
# >>      {:name=>"N.Curran",
# >>       :waves=>
# >>        [{:avg=>0.67, :scores=>[1.0, 0.5, 0.5, 0.5, 1.0], :inteference=>false},
# >>         {:avg=>1.5, :scores=>[1.5, 1.5, 1.5, 1.5, 1.5], :inteference=>false},
# >>         {:avg=>6.33, :scores=>[7.0, 6.5, 6.5, 6.0, 6.0], :inteference=>false},
# >>         {:avg=>4.17, :scores=>[5.0, 4.5, 4.0, 4.0, 4.0], :inteference=>false},
# >>         {:avg=>0.43, :scores=>[0.5, 0.5, 0.3, 0.3, 0.5], :inteference=>false},
# >>         {:avg=>4.83,
# >>          :scores=>[5.5, 5.0, 4.5, 4.5, 5.0],
# >>          :inteference=>false}]}]}}

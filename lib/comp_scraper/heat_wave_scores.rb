module CompScraper
  class HeatWaveScores
    class << self
      # Return the raw info from the top two waves section at the beginning of the page
      def get_top_two_waves_data(page)
        page.css('body > center > table > tr > td > center > table td[align="center"] > table tr').collect do |competitor|
          competitor.css('td.BodyL').collect { |cell| cell.content.strip }
        end
      end

      # Return the info of top two waves and heat summary in a hash
      def get_top_two_waves(page)
        get_top_two_waves_data(page).collect do |competitor|
          if competitor.join('|') =~ /^((\d)\w{2})\|([\w\s-]+)(\((\w+)\s*\))\|([\d\w]+\.[\w\d]{2})p,\s?(Win by|Needs|Comb.)\s([\d\w]+\.[\w\d]{2})/i
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
        end.compact
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
              match = /^(\(\*\))?(\d+\.\d{2})/.match avg.text.strip
              next if match.nil?
              {
                :inteference => !match[1].nil?,
                :avg => match[2].to_f,
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

      # Returns nice data from a heat scores page
      def fetch_data(markup)
        doc = Nokogiri::HTML(markup)
        {
          :top_two_waves => get_top_two_waves(doc),
          :wave_scores => get_competitor_wave_scores(doc)
        }
      end      
    end
  end
end
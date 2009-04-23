module CompScraper
  class RoundHeats
    class << self
      # Return the raw heat data from the page, we'll tidy it up later on
      def get_heats(page)
        page.css('body > center > table table').inject(Array.new) do |heats, heat|
          #It seems like the tables we want have a cellpadding of 5, which seems unique too
          next heats unless heat.get_attribute('cellpadding').to_i == 5
          heats << heat.children.css('td').collect { |cell| cell.content.strip }
        end
      end

      # Get competitor info
      def competitor_info(heat)
        competitor_info, competitors = heat[6..-1], []
        until competitor_info.empty? || competitor_info.size < 5
          competitor = competitor_info.slice!(0..4)
          competitors << {
                :singlet_colour => competitor[0].gsub(/[\\nr]/,''),
                :place => competitor[1].to_i,
                :points => competitor[2].to_f,
                :name => competitor[3],
                :home_country => competitor[4]
              }
        end
        competitors
      end

      # Get the raw heat data and make it more usable
      def process_heat_info(data)
        data.inject(Array.new) do |heats, heat|
          next heats unless heat[0] =~ /(Heat #\s?(\d+)).*(Round (\d+)|Quarter-final|Semifinal|Final)?/m
          match = Regexp.last_match
          heats << {
            :heat_number => match[2],
            :competitors => competitor_info(heat)
          }
        end
      end

      # Return nice data from heats page
      def fetch_data(markup)
        doc = Nokogiri::HTML(markup)
        raw_heats_data = get_heats(doc)
        process_heat_info(raw_heats_data)
      end

    end
  end
end
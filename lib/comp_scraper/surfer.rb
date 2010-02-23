module CompScraper
  class Surfer
    include DataMapper::Resource

    property :id,           Serial
    property :name,         String,   :unique_index => :person, :nullable => false
    property :home_country, String,   :unique_index => :person

    validates_is_unique :name, :scope => :home_country

    has n, :competitors

  end
end
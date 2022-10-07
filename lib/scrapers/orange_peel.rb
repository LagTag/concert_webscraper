require 'open-uri'

module Scrapers
    class OrangePeel
        def parse
            concerts = {}
            venue = Venue.where(name: "The Orange Peel").first
            html = URI.open("https://theorangepeel.net/events/")
            doc = Nokogiri::HTML(html)
            events = doc.css(".eventMainWrapper")
            events.each do |e|
                headliner = e.css("#eventTitle")[0].attributes["title"].value
                artists = [headliner]
                e.css("#evSubHead")[0].elements.each do |sub_artists|
                    artists.push(sub_artists.children.text)
                end
                concerts[headliner] = artists
            end
            concerts.each do |headliner, artists|
                c = Concert.create!(venue: venue)
                artists.compact_blank.each do |a|
                    artist = Artist.find_or_create_by!(name: a)
                    ConcertArtist.create!(artist: artist, concert: c)
                end
            end 
        end
    end
end
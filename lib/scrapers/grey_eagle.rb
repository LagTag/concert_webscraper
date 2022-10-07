require 'open-uri'

module Scrapers
    class GreyEagle
        def parse
            concerts = {}
            venue = Venue.where(name: "The Grey Eagle").first
            month = 0
            date = (DateTime.now + month.month).strftime("%Y-%m")
            html = URI.open("https://www.thegreyeagle.com/calendar/month/#{date}/")
            doc = Nokogiri::HTML(html)
            events = doc.css(".tribe-events-calendar-month__calendar-event-title-link")
            events.each do |e|
                headliner = e.children.text
                artists = [headliner]
                concerts[headliner] = artists
            end
            concerts.each do |headliner, artists|
                c = Concert.create!(venue: venue)
                artists.compact_blank.each do |a|
                    artist = Artist.find_or_create_by!(name: a.strip)
                    ConcertArtist.create!(artist: artist, concert: c)
                end
            end 
        end
    end
end
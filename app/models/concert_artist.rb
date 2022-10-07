class ConcertArtist < ActiveRecord::Base
    belongs_to :artist
    belongs_to :concert
end
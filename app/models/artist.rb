class Artist < ActiveRecord::Base
  has_many :concert_artists
  has_many :concerts, through: :concert_artists
end
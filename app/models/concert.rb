class Concert < ActiveRecord::Base
  has_many :concert_artists
  has_many :artists, through: :concert_artists
  belongs_to :venue
end
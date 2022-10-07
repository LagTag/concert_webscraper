class CreateJoinTableConcertsArtists < ActiveRecord::Migration[7.0]
  def change
    create_join_table :concerts, :artists, table_name: :concert_artists do |t|
      t.index [:concert_id, :artist_id]
      t.index [:artist_id, :concert_id]
    end
  end
end

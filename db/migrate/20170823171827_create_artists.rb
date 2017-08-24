class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name, null: false, index: true
    end

    create_join_table :albums, :artists

    add_foreign_key :albums_artists, :albums
    add_foreign_key :albums_artists, :artists
  end
end

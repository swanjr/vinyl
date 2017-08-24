class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :name, null:false, index: true
      t.string :album_type, null:false
      t.string :released
    end

    add_belongs_to :records, :album, foreign_key: true, index: true
  end
end

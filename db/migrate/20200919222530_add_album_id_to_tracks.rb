class AddAlbumIdToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :album_id, :integer, null: false
    add_index :tracks, :album_id
  end
end

class CreateCoverPhotos < ActiveRecord::Migration
  def change
    create_table :cover_photos do |t|
      t.integer :listing_id

      t.timestamps
    end
  end
end

class RemoveCoverAttributesFromListing < ActiveRecord::Migration
  def change
    remove_column :listings, :cover_file_name
    remove_column :listings, :cover_file_size
    remove_column :listings, :cover_updated_at
    remove_column :listings, :cover_content_type
  end
end

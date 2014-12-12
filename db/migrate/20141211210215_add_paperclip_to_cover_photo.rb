class AddPaperclipToCoverPhoto < ActiveRecord::Migration
  def change
    add_attachment :cover_photos, :image
  end
end

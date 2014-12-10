class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.string :description
      t.decimal :amount, precision: 9, scale: 8
      t.string :address, default: nil
      t.string :token, unique: true
      t.string :key
      t.integer :sales, default: 0
      t.attachment :cover
      t.attachment :document
      t.timestamps
    end
  end
end

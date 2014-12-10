class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :listing
      t.boolean :captured, null: false, default: false
      t.boolean :withdrawn, null: false, default: false
      t.decimal :amount, precision: 9, scale: 8
      t.string :label
      t.string :address
      t.timestamps
    end
  end
end

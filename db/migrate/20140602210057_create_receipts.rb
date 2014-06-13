class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references  :plane, index: true
      t.references  :airport, index: true
      t.date        :receipt_date
      t.string      :receipt_number, :slug, :vendor_name
      t.string      :status, default: :pending
      t.decimal     :fuel_cost, :gallons

      t.timestamps
    end

    add_index :receipts, :slug,  unique: true

  end
end

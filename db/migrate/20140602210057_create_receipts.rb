class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references  :plane, index: true
      t.references  :airport, index: true
      t.date        :receipt_date
      t.string      :fuel_cost, :gallons, :receipt_number, :slug, :vendor_name
      t.string      :status, default: :pending

      t.timestamps
    end

    add_index :receipts, :slug,  unique: true

  end
end

class AddReimbursementToReceipts < ActiveRecord::Migration
  def change
    change_table :receipts do |t|
      t.string :reimbursement
    end
  end
end

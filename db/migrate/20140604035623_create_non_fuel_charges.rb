class CreateNonFuelCharges < ActiveRecord::Migration
  def change
    create_table :non_fuel_charges do |t|
      t.references  :receipt, index: true
      t.string      :student_name, :charge_type, :amount
      t.string      :status, default: :pending

      t.timestamps
    end
  end
end

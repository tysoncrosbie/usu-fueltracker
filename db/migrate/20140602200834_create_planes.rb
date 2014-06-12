class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string  :fuel_type, :tail_number, :plane_type, :slug
      t.string  :status, default: :active

      t.timestamps
    end

    add_index :planes, :slug,   unique: true

  end
end

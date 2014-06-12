class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :type, :name, :slug
      t.date :starts_on, :ends_on

      t.timestamps
    end

    add_index :reports, :slug,  unique: true
  end
end

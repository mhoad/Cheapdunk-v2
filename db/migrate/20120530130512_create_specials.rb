class CreateSpecials < ActiveRecord::Migration
   def change
    create_table :specials do |t|
      t.integer :venue_id
      t.string :name
      t.text :description
      t.timestamp :special_starts_at
      t.timestamp :special_finishes_at
      t.boolean :available_monday
      t.boolean :available_tuesday
      t.boolean :available_wednesday
      t.boolean :available_thursday
      t.boolean :available_friday
      t.boolean :available_saturday
      t.boolean :available_sunday
      t.datetime :end_date

      t.timestamps
    end
  end
end

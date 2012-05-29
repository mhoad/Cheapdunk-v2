class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.string :street_address
      t.integer :postcode
      t.string :suburb
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end

class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :venue_id
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end

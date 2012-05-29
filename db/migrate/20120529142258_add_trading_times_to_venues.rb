class AddTradingTimesToVenues < ActiveRecord::Migration
  def self.up
    create_table :trading_times do |t|
      t.integer :venue_id
      t.timestamp :monday_opens_at
      t.timestamp :monday_closes_at
      t.timestamp :tuesday_opens_at
      t.timestamp :tuesday_closes_at
      t.timestamp :wednesday_opens_at
      t.timestamp :wednesday_closes_at
      t.timestamp :thursday_opens_at
      t.timestamp :thursday_closes_at
      t.timestamp :friday_opens_at
      t.timestamp :friday_closes_at
      t.timestamp :saturday_opens_at
      t.timestamp :saturday_closes_at
      t.timestamp :sunday_opens_at
      t.timestamp :sunday_closes_at
    end
  end

  def self.down
    drop_table :trading_times
  end
end

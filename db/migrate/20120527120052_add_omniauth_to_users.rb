class AddOmniauthToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :oauth, :boolean, :default => false
  end

  def self.down
    remove_column :users, :oauth
  end
end


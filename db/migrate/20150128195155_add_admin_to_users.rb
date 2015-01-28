class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :extra_access, :boolean, :default => false
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :extra_access
    remove_column :users, :admin
  end
end

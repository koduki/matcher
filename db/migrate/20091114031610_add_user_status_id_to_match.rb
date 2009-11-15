class AddUserStatusIdToMatch < ActiveRecord::Migration
  def self.up
    add_column :matches, :user_status_id, :string
  end

  def self.down
    remove_column :matches, :user_status_id
  end
end

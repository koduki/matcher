class AlterUserStatusIdToMatch < ActiveRecord::Migration
  def self.up
    remove_column :matches, :user_status_id
    add_column :matches, :user_status_id, :integer
  end

  def self.down
    remove_column :matches, :user_status_id
    add_column :matches, :user_status_id, :string
  end
end

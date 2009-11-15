class AddBotNameToMatch < ActiveRecord::Migration
  def self.up
    add_column :matches, :bot_name, :string
  end

  def self.down
    remove_column :matches, :bot_name
  end
end

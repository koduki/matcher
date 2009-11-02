class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :twitter_id
      t.text :message
      t.integer :to_status_id
      t.string :to_user_name

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end

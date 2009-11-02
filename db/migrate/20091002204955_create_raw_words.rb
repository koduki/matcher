class CreateRawWords < ActiveRecord::Migration
  def self.up
    create_table :raw_words do |t|
      t.integer :twitter_id
      t.string :user_name
      t.string :reading
      t.string :surface
      t.string :pos

      t.timestamps
    end
  end

  def self.down
    drop_table :raw_words
  end
end

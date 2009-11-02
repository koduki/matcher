class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :twitter_id
      t.text :post_status
      t.text :user_status
      t.string :introduce_to_user
      t.string :introduced_by_user

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end

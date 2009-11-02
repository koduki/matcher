class AddIndexRawWords < ActiveRecord::Migration
  def self.up
	 add_index :raw_words, :twitter_id
	 add_index :raw_words, :pos
	 add_index :raw_words, :user_name
	 add_index :raw_words, :reading
  end

  def self.down
	 remove_index :raw_words, :twitter_id
	 remove_index :raw_words, :pos
	 remove_index :raw_words, :user_name 
	 remove_index :raw_words, :reading
  end
end

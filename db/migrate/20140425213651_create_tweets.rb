class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :record_id
      t.text :tweet_text

      t.timestamps
    end
  end
end

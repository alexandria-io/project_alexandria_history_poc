class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :archive_id
      t.integer :favorite_count
      t.string :filter_level
      t.string  :in_reply_to_screen_name
      t.string :in_reply_to_attrs_id
      t.string :in_reply_to_status_id
      t.string :in_reply_to_user_id
      t.string  :lang
      t.integer :retweet_count
      t.string  :source
      t.text :tweet_text
      t.timestamp :created_date

      t.timestamps
    end
  end
end

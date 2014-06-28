class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string   :archive_term
      t.string   :archive_type
      t.string   :archive_title
      t.integer  :archive_time_length
      t.string   :florincoin_address
      t.decimal  :florincoin_price
      t.datetime :archive_start_date
      t.datetime :archive_end_date
      t.string   :archive_start_date_formatted
      t.boolean  :creating_archive, default: false

      t.timestamps
    end
  end
end

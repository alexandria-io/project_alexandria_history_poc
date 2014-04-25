class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :archive_id
      t.string :record_type

      t.timestamps
    end
  end
end

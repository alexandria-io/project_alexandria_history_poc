class CreateArchiveItems < ActiveRecord::Migration
  def change
    create_table :archive_items do |t|
      t.integer :archive_id
      t.string :item_term
      t.string :item_type

      t.timestamps
    end
  end
end

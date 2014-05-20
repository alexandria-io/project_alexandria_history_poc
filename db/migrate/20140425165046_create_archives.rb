class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :title
      t.integer :account_id
      t.string :slug

      t.timestamps
    end
    add_index :archives, :slug, unique: true
  end
end

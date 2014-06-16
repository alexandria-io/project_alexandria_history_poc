class CreateTorrents < ActiveRecord::Migration
  def change
    create_table :torrents do |t|
      t.integer :archive_id
      t.string :title

      t.timestamps
    end
  end
end

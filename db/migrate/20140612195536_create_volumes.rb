class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.integer :archive_id
      t.string :volume_title

      t.timestamps
    end
  end
end

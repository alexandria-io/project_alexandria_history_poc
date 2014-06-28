class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.integer :archive_id
      t.string :volume_title
      t.datetime :volume_start_date
      t.datetime :volume_end_date

      t.timestamps
    end
  end
end

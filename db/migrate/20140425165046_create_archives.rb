class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :archive_term
      t.string :archive_type

      t.timestamps
    end
  end
end

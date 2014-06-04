class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :archive_term
      t.string :archive_type
      t.string :florincoin_address
      t.decimal :florincoin_price

      t.timestamps
    end
  end
end

class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :volume_id
      t.string :page_title
      t.text :page_text

      t.timestamps
    end
  end
end

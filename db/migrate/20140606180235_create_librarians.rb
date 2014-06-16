class CreateLibrarians < ActiveRecord::Migration
  def change
    create_table :librarians do |t|
      t.string :title

      t.timestamps
    end
  end
end

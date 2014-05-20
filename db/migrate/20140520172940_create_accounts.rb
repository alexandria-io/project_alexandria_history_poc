class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :address
      t.string :slug

      t.timestamps
    end
    add_index :accounts, :slug, unique: true
  end
end

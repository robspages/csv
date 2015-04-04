class CreateRows < ActiveRecord::Migration
  def self.up
    create_table :rows do |t|
      t.integer :import_id
      t.integer :field_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :rows
  end
end

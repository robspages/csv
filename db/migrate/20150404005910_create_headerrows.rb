class CreateHeaderrows < ActiveRecord::Migration
  def self.up
    create_table :headerrows do |t|
      t.integer :field_id
      t.integer :import_id

      t.timestamps
    end
  end

  def self.down
    drop_table :headerrows
  end
end

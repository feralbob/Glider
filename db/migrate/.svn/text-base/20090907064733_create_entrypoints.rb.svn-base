class CreateEntrypoints < ActiveRecord::Migration
  def self.up
    create_table :entrypoints do |t|
      t.column 'id', :bigint
      t.column 'chain_id', :bigint
      t.timestamps
    end
  end

  def self.down
    drop_table :entrypoints
  end
end

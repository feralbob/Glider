class CreateChains < ActiveRecord::Migration
  def self.up
    create_table :chains do |t|
      t.column 'id', :bigint
      t.column 'presenting', :boolean, :default => false, :null => false
      t.column 'presented', :boolean, :default => false, :null => false
      t.column 'description', :text
      t.column 'votes', :bigint, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :chains
  end
end

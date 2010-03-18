class Questions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.column 'id', :bigint
      t.column 'votes', :bigint, :default => 0
      t.column 'question', :text
      t.timestamps
    end

  end

  def self.down
    drop_table :questions
  end
end

class CreateSlides < ActiveRecord::Migration
  def self.up
    create_table :slides do |t|
      t.column 'id', :bigint
      t.column 'slide_id', :bigint
      t.column 'slide_build_id', :bigint
      t.column 'sequence_id', :bigint
      t.column 'original_sequence_id', :bigint
      t.column 'chain_id', :bigint
      t.column 'png', :binary, :limit => 3.megabytes
      t.column 'png_large_preview', :binary, :limit => 2.megabytes
      t.column 'png_small_preview', :binary 
      t.column 'presenting', :boolean, :default => false, :null => false
      t.column 'presented', :boolean, :default => false, :null => false
      t.timestamps
    end

    add_index(:slides, :id)
    add_index(:slides, :slide_id)
    add_index(:slides, :sequence_id)
    add_index(:slides, :original_sequence_id)
    add_index(:slides, :chain_id)
  end

  def self.down
    drop_table :slides
  end
end

class CreateChainVoteTokens < ActiveRecord::Migration
  def self.up
    create_table :chain_vote_tokens do |t|
      t.column 'id', :bigint
      t.column 'chain_id', :bigint
      t.column 'token', :text
      t.timestamps
    end
  end

  def self.down
    drop_table :chain_vote_tokens
  end
end

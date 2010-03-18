class CreateQuestionVoteTokens < ActiveRecord::Migration
  def self.up
    create_table :question_vote_tokens do |t|
      t.column 'id', :bigint
      t.column 'question_id', :bigint
      t.column 'token', :text
      t.timestamps
    end
  end

  def self.down
    drop_table :question_vote_tokens
  end
end

class Question < ActiveRecord::Base
  validates_uniqueness_of :question
  validates_presence_of :question
  
  def token_voted_already?(token)
    QuestionVoteToken.find(:first, :conditions => ["question_id = ? AND token = ?", self.id, token])
  end
end

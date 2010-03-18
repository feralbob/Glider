class QuestionController < ApplicationController
  before_filter :auth_session
  layout 'chat'

  def list
    # why doesn't it give an array of one on one result ffs?
    @questions = Question.find(:all, :order => 'votes DESC')
  end

  def create
    @question = Question.new(params[:question])
    @question.save
    redirect_to :controller => 'question', :action => 'list'
  end

  def vote_up
    question = Question.find(params[:id])
    unless question.token_voted_already?(session[:token])
      question.votes += 1
      question.save
      qvt = QuestionVoteToken.new
      qvt.question_id = question.id
      qvt.token = session[:token]
      qvt.save
    end
    redirect_to :controller => 'question', :action => 'list'
  end

end

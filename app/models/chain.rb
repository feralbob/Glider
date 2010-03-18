class Chain < ActiveRecord::Base
  has_many :slides, :order => 'sequence_id'

  def exits
    # FIXME turn this in to a has_many or whatever?  
    ids = ChainExit.find(:all, :conditions => ['chain_id = ?', id]).collect { |ce| ce.chain_exit_id }

    Chain.find(ids, :order => 'votes DESC')
  end

  # FIXME probably better to distribute all these methods across models or something. Maybe put them in /lib or something.

  def self.presentation_running?
    Chain.find(:all, :conditions => ["presenting = ?", true]).count > 0
  end

  def self.current_chain()
    chain = Chain.find(:first, :conditions => ["presenting = ? AND presented = ?", true, false])
  end

  def self.on_last_slide_in_chain?(current_chain = nil)
    current_chain = Chain.current_chain unless current_chain 
    Slide.find(:all, :conditions => ["chain_id = ? AND presented = ?", current_chain.id, false]).count == 1
  end


  #FIXME probably a better name for this one
  def self.reset_presentation
    Chain.update_all(["presented = ?, presenting = ?", false, false])
  end

  def token_voted_already?(token)
    ChainVoteToken.find(:first, :conditions => ["chain_id = ? AND token = ?", self.id, token])
  end

end

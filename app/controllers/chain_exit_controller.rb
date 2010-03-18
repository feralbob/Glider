class ChainExitController < ApplicationController

  def create
    chain_exit = ChainExit.new
    chain_exit.chain_id = params[:chain_from_id]
    chain_exit.chain_exit_id = params[:chain_exit_id]
    chain_exit.save
    redirect_to :controller => 'chain', :action => 'edit', :id => params[:chain_from_id]
  end
end

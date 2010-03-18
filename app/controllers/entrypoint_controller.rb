class EntrypointController < ApplicationController
  before_filter :authorize_local_access
  layout 'main'

  def view
    if Chain.count == 0
      redirect_to :controller => 'chain', :action => 'list'
    end

    @chains = Chain.find(:all)

    if Entrypoint.count == 0
      @entrypoint = nil
    else
      @entrypoint = Entrypoint.find(:first)
      @chains = @chains - [@entrypoint.chain]
    end


  end

  def create
    Entrypoint.find(:all).each do |entrypoint|
      entrypoint.destroy
    end

    if params[:chain_id]
      chain = Chain.find(params[:chain_id])
      puts chain.id
      unless Entrypoint.count > 0
        entrypoint = Entrypoint.new
        entrypoint.chain_id = chain.id
        entrypoint.save!
      end
      redirect_to :action => 'view'
    end
  end
end
